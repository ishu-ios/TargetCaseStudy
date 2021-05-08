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
        if let sale = item.salePrice {
            view.salePriceLabel.text = sale
            let attrString = NSAttributedString(string: item.price, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            view.priceLabel.attributedText = attrString
           
        } else {
            view.priceLabel.text = ""
            view.salePriceLabel.text = item.price
        }
        
        
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
        if let _items = item as? DetailItemViewState {
           let height =  _items.description.height(withConstrainedWidth: (width - 32), font: UIFont.systemFont(ofSize: 17))
            let computedHeight = height + 500
            
            return computedHeight
        }
        
        return 1000
       
    }
}
