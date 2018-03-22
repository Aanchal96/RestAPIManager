//
//  APIManager.swift
//  RestAPIManager
//
//  Created by Appinventiv on 19/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
import UIKit

class APIManager {
    
    func loginGet(parameters: [String:Any], success: @escaping (Entitites) -> Void){
        
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "31c411b7-c48e-4411-a656-e595f11aa7c2"
        ]
        let newString = stringMutation(parameters)
        let baseURL = "https://httpbin.org/get?Username=\(newString)&Password=\(parameters["Password"]!)"
        
        NetworkManager().GET(headers: headers, url: baseURL, success:{ (data) in
            print(".......")
            print(data)
            success(Entitites(args: data))}){error in print(Error.self)}
    }
    
    func stringMutation(_ parameters: [String:Any])-> String{
        let str = parameters["Username"] as? String
        let newStr = str?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        return newStr!
    }
    
    func loginPost(params: [String:Any],onSuccess success: @escaping (Entitites) -> Void){
            
            let parameters = [
                [
                    "name": "Username",
                    "value": "Aanchal"
                ],
                [
                    "name": "Password",
                    "value": "12345"
                ]
            ]
            
            let headers = [
                "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                "Cache-Control": "no-cache",
                "Postman-Token": "aa8e1c98-3cbf-4d74-ac99-504c274a91a5"
            ]
            
            let baseURL = "https://httpbin.org/post"
        
            let body = "Username=\(params["Username"])&Password=\(params["Password"]!)"
//            let error: NSError? = nil
//            for param in parameters {
//                let paramName = param["name"]!
//                body += "--\(boundary)\r\n"
//                body += "Content-Disposition:form-data; name=\"\(paramName)\""
//                if let filename = param["fileName"] {
//                    let contentType = param["content-type"]!
//                    let fileContent = try! String(contentsOfFile: filename, encoding: String.Encoding.utf8)
//                    if (error != nil) {
//                        print(error!)
//                    }
//                    body += "; filename=\"\(filename)\"\r\n"
//                    body += "Content-Type: \(contentType)\r\n\r\n"
//                    body += fileContent
//                }
//                else if let paramValue = param["value"] {
//                    body += "\r\n\r\n\(paramValue)"
//                }
//            }

            NetworkManager().POST(headers: headers, body: body, url: baseURL){(data) in
success(Entitites(args: data))}
        }
}
