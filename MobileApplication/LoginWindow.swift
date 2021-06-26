//
//  LoginWindow.swift
//  MobileApplication
//
//  Created by Lukas Weber on 15.06.21.
//  Copyright © 2021 Lukas Weber. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class Login: UIViewController, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.performSegue(withIdentifier: "ToPhoto", sender: self)
        print(GIDSignIn.sharedInstance()?.currentUser)
    }
    
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    

    @IBOutlet weak var nextPageButton: UIButton!
    
    var ref: DatabaseReference!
    var isTrue = false
    
    @IBOutlet var signInButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        nextPageButton.isHidden = true
    }
    
    
    func txtFldIsEmpty() {
        if usernameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" || passwordTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            loginBtn.isEnabled = true
        }
    }
    
    @IBAction func GoogleButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ToPhoto", sender: self)
        nextPageButton.isHidden = false
        isTrue = false
        print(isTrue)
        
    }
    
    @IBAction func LoginAction(_ sender: Any) {
      
        
       
        
        ref = Database.database().reference()
        
        let roofRef = FirebaseDatabase.Database.database().reference()
    
 
           
                    
    }
}
