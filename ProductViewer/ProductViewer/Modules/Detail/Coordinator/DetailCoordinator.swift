//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by user on 06/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product Deatil
 */
class DetailCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: DetailViewState {
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
    
    lazy var viewController: DetailViewController = {
        return DetailViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = DetailViewState(detailItems: [] )// ListViewState(listItems: [])
       //updateState()
        
        registerListeners()
    }
    
    // MARK: DetailCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(AddToCardPressed.self) { [weak self] e in
            var title = ""
            if let _title = e.product {
                title = _title
            }
            let alert = UIAlertController(title: "\(title)", message: "Product added in your cart 🐶", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
            self?.viewController.present(alert, animated: true, completion: nil)
        }
        
        dispatcher.addObserver(AddToListPressed.self) { [weak self] e in
            var title = ""
            if let _title = e.product {
                title = _title
            }
            let alert = UIAlertController(title: "\(title)", message: "Product added in your list 🐶", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
            self?.viewController.present(alert, animated: true, completion: nil)
        }
    }
    

    
    func updateProductsState(product:ProductElement) {
        viewState.detailItems = [DetailItemViewState(name: product.title ?? "", description: product.productDescription ?? "", price: product.regularPrice?.displayString ?? "$0.0", salePrice: product.salePrice?.displayString, imageUrl: product.imageURL ?? "")]
        
    }
    
    func getProductDetail(_ productId:Int) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.networkService.webRequest(ProductRouter.getProductDetail(productId)) { data in
                let productsResponse = try? JSONDecoder().decode(ProductElement.self, from: data)
                if let product = productsResponse {
                    self?.updateProductsState(product: product)
                } else {
                    print("Unable to decode json for contact list.")
                }
            } _: { (error) in
                print("Error : \(error)")
            }
        }
    }
}
