//
//  Entities.swift
//  RestAPIManager
//
//  Created by Appinventiv on 20/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation
struct Entities{
    
    let pass: String
    let user: String
    let origin: String
    
    init(args: JSON){
        
        self.pass = args["args"]["Password"].string!
        self.user = args["args"]["Username"].string!
        self.origin = args["origin"].string!
    }
}


