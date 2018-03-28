//
//  ViewController.swift
//  RestAPIManager
//
//  Created by Appinventiv on 19/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:--> Variable Declaration
    var boolean = false
    var args = ["":""]
    var forms = ["":""]
    var user = ""
    var pass = ""
    var origin = ""
    
    //MARK:--> Outlets
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var originLabel: UILabel!
    
    @IBAction func getDetailsBtn(_ sender: Any) {
        
        self.args["Username"] = self.userNameTF.text
        self.args["Password"] = self.passwordTF.text
        
        //MARK:--> Calling GET Request
        self.getAPI()
        
        //MARK:--> Displaying labels
        self.getLabels()
    }
    
    @IBAction func postDetailsBtn(_ sender: Any) {
        self.forms["Username"] = self.userNameTF.text
        self.forms["Password"] = self.passwordTF.text
        
        //MARK:--> Calling POST Request
        self.postAPI()
        
        //MARK:--> Displaying labels
        self.getLabels()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController{
    
    //MARK: --> Getting API for GET method
    func getAPI(){
        APIManager().loginGet(parameters: self.args){(args) in
            DispatchQueue.main.async {
                self.user = "Account's Owner:  \(args.user) "
                self.pass = "Account's Password:  \(args.pass) "
                self.origin = "Login from IP: \(args.origin) "
            }}
    }
    
    //MARK: --> Getting API for POST method
    func postAPI(){
        
        APIManager().loginPost(forms: self.forms, success: {(args) in
            DispatchQueue.main.async {
                self.user = "Account's Owner:  \(args.user) "
                self.pass = "Account's Password:  \(args.pass) "
                self.origin = "Login from IP: \(args.origin) "
            }}){ (error) in
                print(error)
        }
    }
    
    //MARK:--> Writing Labels
    func getLabels(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:{
            self.userNameLabel.text = self.user
            self.passwordLabel.text = self.pass
            self.originLabel.text = self.origin
            
            //MARK: --> Displaying the labels
            self.userNameLabel.isHidden = self.boolean
            self.passwordLabel.isHidden = self.boolean
            self.originLabel.isHidden = self.boolean
        })
    }
}
