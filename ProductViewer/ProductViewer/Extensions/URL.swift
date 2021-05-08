//
//  URL.swift
//  ProductViewer
//
//  Created by user on 07/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension URL {
    
    var isValidURL: Bool {
        get {
            if let host = self.host, !host.isEmpty {
                return true
            }
            return false
        }
    }
}
