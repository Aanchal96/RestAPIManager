//
//  ViewController.swift
//  RestAPIManager
//
//  Created by Appinventiv on 19/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var boolean = false
    var args = ["":""]
    var forms = ["":""]
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    @IBAction func getDetailsBtn(_ sender: Any) {
        self.args["Username"] = userNameTF.text
        self.args["Password"] = passwordTF.text
        
        APIManager().loginGet(parameters: self.args){(args) in
            DispatchQueue.main.async {
                self.userNameLabel.text = "Account's Owner:  \(args.user) "
                self.passwordLabel.text = "Account's Password:  \(args.pass) "
                self.originLabel.text = "Login from IP: \(args.origin) "
                self.userNameLabel.isHidden = self.boolean
                self.passwordLabel.isHidden = self.boolean
                self.originLabel.isHidden = self.boolean
            }}
    }
    
    @IBAction func postDetailsBtn(_ sender: Any) {
                self.forms["Username"] = userNameTF.text
                self.forms["Password"] = passwordTF.text
        
                APIManager().loginPost(params: self.forms){(args) in
                    DispatchQueue.main.async {
                        self.userNameLabel.text = args.user
                        self.passwordLabel.text = args.pass
                        self.userNameLabel.isHidden = self.boolean
                        self.passwordLabel.isHidden = self.boolean
                        self.originLabel.isHidden = self.boolean
                    }}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

