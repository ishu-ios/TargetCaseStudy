//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
        view.aisleLabel.layer.borderWidth = 1.0
        view.aisleLabel.layer.borderColor = HarmonyColor.targetStrokeGrayColor.cgColor
        view.aisleLabel.layer.cornerRadius = view.aisleLabel.frame.width / 2
        view.aisleLabel.layer.masksToBounds = true
        
        view.layer.borderWidth = 1.0
        view.layer.borderColor =  HarmonyColor.targetStrokeGrayColor.cgColor
        view.layer.cornerRadius = 3.0
        view.layer.masksToBounds = true
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
        view.titleLabel.text = item.title
        if let sale = item.salePrice {
            view.priceLabel.text = sale
            let attrString = NSAttributedString(string: item.price, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            view.regularPriceLabel.attributedText = attrString
           
        } else {
            view.regularPriceLabel.text = ""
            view.priceLabel.text = item.price
        }
        view.priceLabel.text = item.price
        view.aisleLabel.text = item.aisle.uppercased()
        view.productImage.loadImageUsingCache(withUrl: item.imageUrl, placholder: UIImage(named: "1"))

    }
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
        dispatcher?.triggerEvent(ListItemPressed(productId: item.productId))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 100.0
    }
}

