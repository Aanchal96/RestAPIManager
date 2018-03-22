//
//  NetworkManager.swift
//  RestAPIManager
//
//  Created by Appinventiv on 20/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class NetworkManager{
    
    // GET Request
    
    func GET(headers: [String:String], url: String, success: @escaping (JSON)->(), failure: @escaping(Error) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                failure(error!)
            }
            else {
                guard let url = URL(string: url) else{return}
                do{
                 let data = try String(contentsOf: url)
                 let json = JSON(parseJSON: data)
                 success(json)
                }
                catch(let error){
                    failure(error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    //POST Request
    
    func POST(headers: [String:String],body: String, url: String, success: @escaping (JSON)->()){
            
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: String.Encoding.ascii)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
}
