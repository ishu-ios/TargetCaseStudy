//
//  NetworkService.swift
//  ProductViewer
//
//  Created by user on 06/05/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

//MARK:- NetworkService Protocol to hit a service
protocol NetworkServiceProtocol {
    
    func webRequest(_ endPoint: ProductRouter, _ success: @escaping(Data) -> Void, _ failure: @escaping(Error) -> Void)
}

//MARK:- NetworkService class to hit web services
class NetworkService: NetworkServiceProtocol {
    
    func webRequest(_ endPoint: ProductRouter, _ success: @escaping (Data) -> Void, _ failure: @escaping (Error) -> Void) {
        
        let headers = ["Content-Type": "application/json"]
        
        let request = NSMutableURLRequest(url: endPoint.getURL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = endPoint.getHTTPMethod
        
        if endPoint.getHTTPMethod.uppercased() == "POST" ||
            endPoint.getHTTPMethod.uppercased() == "PUT" {
            let postData = try? JSONSerialization.data(withJSONObject: endPoint.getRequestParameter,
                                                       options: [])
            request.httpBody = postData
        }
        request.allHTTPHeaderFields = endPoint.getHTTPMethod.uppercased() == "DELETE" ? [:] : headers
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { (data, response, error) -> Void in
                                            if error != nil, let error = error {
                                                failure(error)
                                            } else if let data = data {
                                                success(data)
                                            }
        })
        dataTask.resume()
    }
    
    
}

