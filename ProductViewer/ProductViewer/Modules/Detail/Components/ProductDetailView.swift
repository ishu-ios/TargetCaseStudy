//
//  ProductDetailView.swift
//  ProductViewer
//
//  Created by user on 07/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit
import Tempo

final class ProductDetailView: UIView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var addToCardHandler: (() -> Void)!
    var addToListHandler: (() -> Void)!
    
    @IBAction func addToCardAction() {
        addToCardHandler()
    }
    
    @IBAction func addToListAction() {
         addToListHandler()
    }
    

}

extension ProductDetailView: ReusableNib {
    @nonobjc static let nibName = "ProductDetailView"
    @nonobjc static let reuseID = "ProductDetailViewIdentifier"

    @nonobjc func prepareForReuse() {
        
    }
    
}
