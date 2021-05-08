//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by user on 06/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

/// Detail view state
struct DetailViewState: TempoViewState, TempoSectionedViewState {
    var detailItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return detailItems
    }
}

/// View state for each list item.
struct DetailItemViewState: TempoViewStateItem, Equatable {
    let name: String
    let description: String
    let price: String
    let salePrice: String?
    let imageUrl: String
}

func ==(lhs: DetailItemViewState, rhs: DetailItemViewState) -> Bool {
    return lhs.description == rhs.description
        && lhs.price == rhs.price
        && lhs.salePrice == rhs.salePrice
        && lhs.imageUrl == rhs.imageUrl
        && lhs.name == rhs.name
}


