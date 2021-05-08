//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    lazy var networkService: NetworkService = {
        return NetworkService()
    }()
    
    lazy var detailCoordinator: DetailCoordinator = {
        return DetailCoordinator()
    }()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
       //updateState()
        getProductList()
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e in
            
            self?.detailCoordinator.getProductDetail(e.productId)
            if  let detail = self?.detailCoordinator.viewController {
                // detail.modalTransitionStyle = .flipHorizontal
                self?.viewController.present(detail, animated: true, completion: {
                    // Handle some post present
                })
            }
            
        }
    }

    func updateProductsState(products:[ProductElement]) {
        viewState.listItems = products.map { product in
            ListItemViewState(productId: product.id ?? 0, title: product.title ?? "NO Product", price: product.regularPrice?.displayString ?? "$0.0", aisle: product.aisle ?? "B2",imageUrl: product.imageURL ?? "")
        }
        DispatchQueue.main.async {
            self.viewController.showHideLoading(show: false)
        }
    }
    
    func getProductList() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.networkService.webRequest(ProductRouter.getProductList) { data in
                let productsResponse = try? JSONDecoder().decode(ProductsResponse.self, from: data)
                if let products = productsResponse?.products {
                    self?.updateProductsState(products: products)
                } else {
                    print("Unable to decode json for contact list.")
                }
            } _: { (error) in
                print("Error : \(error)")
            }
        }
    }
    
    
}
