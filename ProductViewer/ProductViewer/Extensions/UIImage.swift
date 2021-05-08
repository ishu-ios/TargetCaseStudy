//
//  UIImage.swift
//  ProductViewer
//
//  Created by user on 07/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString,UIImage>()

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String, placholder: UIImage?) {
        
        self.image = placholder
        let url = URL(string: urlString)
        if url == nil { return }
        if let finalURL = url,
            !finalURL.isValidURL { return }
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}
