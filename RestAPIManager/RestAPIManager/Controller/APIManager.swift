//
//  APIManager.swift
//  RestAPIManager
//
//  Created by Appinventiv on 19/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
import UIKit

class APIManager {
    
    let headers = [
        "Cache-Control": "no-cache",
        "Postman-Token": "31c411b7-c48e-4411-a656-e595f11aa7c2"
    ]
    
    func loginGet(parameters: [String:Any], success: @escaping (Entities) -> Void){
        
        let newString = self.stringMutation(parameters)
        let baseURL = "https://httpbin.org/get?Username=\(newString)&Password=\(parameters["Password"]!)"
        
        NetworkManager().GET(headers: headers, url: baseURL, success:{ (data) in
            success(Entities(args: data))}){error in print(Error.self)}
    }
    
    func loginPost(forms: [String:Any], success: @escaping (Entities) -> Void,  failure: (Error)-> Void){
        let headers = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "Cache-Control": "no-cache",
            "Postman-Token": "177f5629-33da-45a5-992e-2a8565919c11"
        ]
        let newString = self.stringMutation(forms)
        let baseURL = "https://httpbin.org/post?Username=\(newString)&Password=\(forms["Password"]!)"
        
        let body = "Username=\(newString)&Password=\(forms["Password"]!)"
        
        NetworkManager().POST(headers: headers, body: body, url: baseURL, success: {(data) in success(Entities(args: data))}){(error) in print(Error.self)
        }
    }
}

extension APIManager{
    
    //Creating a url string
    
    func stringMutation(_ dict: [String:Any])-> String{
        let str = dict["Username"] as? String
        let newStr = str?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        return newStr!
    }
}

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
