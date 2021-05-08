//
//  ProductDetailComponent.swift
//  ProductViewer
//
//  Created by user on 07/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

struct ProductDetailComponent: Component {
   

    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductDetailView, item: DetailItemViewState) {

    }

    func configureView(_ view: ProductDetailView, item: DetailItemViewState) {
        view.descriptionLabel.text = item.description
        view.priceLabel.text = item.price
        view.productImage.loadImageUsingCache(withUrl: item.imageUrl, placholder: UIImage(named: "1"))
        
       
        view.addToListHandler = {
            dispatcher?.triggerEvent(AddToListPressed(product: item.name))
        }
        
        view.addToCardHandler = {
            dispatcher?.triggerEvent(AddToCardPressed(product: item.name))
        }
    }

    func shouldSelectView(_ view: ProductDetailView, viewState: DetailItemViewState) -> Bool {
        return false
    }

    
}

extension ProductDetailComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        
        // TODO : Need automatic calculated height 
        return 1000
    }
}