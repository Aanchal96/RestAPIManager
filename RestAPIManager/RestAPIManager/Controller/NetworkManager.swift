//
//  NetworkManager.swift
//  RestAPIManager
//
//  Created by Appinventiv on 20/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation

class NetworkManager{
    
    //MARK:--> GET Request
    func GET(headers: [String:String], url: String, success: @escaping (JSON)->(), failure: @escaping(Error) -> Void){
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        fetchRequest(headers, request, url, success, failure)
    }
    
    //MARK:--> POST Request
    func POST(headers: [String:String],body: String, url: String, success: @escaping (JSON)->(), failure: @escaping(Error) -> Void){
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        fetchRequest(headers, request, url, success, failure)
    }
    
    //MARK: --> Function to create URL session
    fileprivate func fetchRequest(_ headers: [String:String], _ request: NSMutableURLRequest, _ url: String,_ success: @escaping (JSON) -> (), _ failure: @escaping (Error) -> Void) {
        
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("No response retrieved")
                failure(error!)
            }
            else {
                do{
                    guard let data = data else{return}
                    let json = try JSON(data: data)
                    success(json)
                }
                catch(let error){
                    print("No JSON fetched")
                    failure(error)
                }
            }
        })
        dataTask.resume()
    }
}
