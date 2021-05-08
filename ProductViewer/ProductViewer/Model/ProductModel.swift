//
//  ProductModel.swift
//  ProductViewer
//
//  Created by user on 07/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

// MARK: - ProductElement
struct ProductElement: Codable {
    var id: Int?
    var title, aisle, productDescription: String?
    var imageURL: String?
    var regularPrice, salePrice: Price?

    enum CodingKeys: String, CodingKey {
        case id, title, aisle
        case productDescription = "description"
        case imageURL = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
    }
}

// MARK: - Price
struct Price: Codable {
    var amountInCents: Int?
    var currencySymbol, displayString: String?

    enum CodingKeys: String, CodingKey {
        case amountInCents = "amount_in_cents"
        case currencySymbol = "currency_symbol"
        case displayString = "display_string"
    }
}
