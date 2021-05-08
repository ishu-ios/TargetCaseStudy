//
//  ProductRouter.swift
//  ProductViewer
//
//  Created by user on 06/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

// MARK: - Product
struct ProductsResponse: Codable {
    var products: [ProductElement]?
}


enum ProductRouter {
    
    case getProductList
    case getProductDetail(Int)
   

    var baseURL: String {
        
        return "https://api.target.com/mobile_case_study_deals/v1"
    }
    
    var getURL: URL {
        
        switch self {
        case .getProductList:
            return URL(string: "\(baseURL)/deals")!
            
        case .getProductDetail(let productId):
            return URL(string: "\(baseURL)/deals/\(productId)")!
            
      
        }
    }
    
    var getRequestParameter: [String:AnyObject] {
        
        switch self {
        case .getProductList, .getProductDetail:
            return [:]
        }
    }
    
    var getHTTPMethod: String {
        
        switch self {
        case .getProductList, .getProductDetail:
            return "GET"
            
        }
    }
    
}

