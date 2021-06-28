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
import FBSDKLoginKit
import AuthenticationServices

class Login: UIViewController, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.performSegue(withIdentifier: "ToPhoto", sender: self)
    }
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var fbButton: UIView!
    @IBOutlet weak var errorText: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    var ref: DatabaseReference!
    
    var actionCodeSetting = ActionCodeSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        let loginButtonFB = FBLoginButton()
        self.fbButton.addSubview(loginButtonFB)
        fbButton.backgroundColor = .clear
        
               if let token = AccessToken.current, !token.isExpired {
                   
                   loginButtonFB.permissions = ["public_profile", "email"]
               }
        
        if AccessToken.isCurrentAccessTokenActive {
          print("your session is active")
        
        }
        
        signUpButtonLook()
    }
    
    func signUpButtonLook() {
        signUpButton.tintColor = UIColor(red: 5/255, green: 126/255, blue: 255/255, alpha: 1)
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderColor = UIColor(red: 5/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        signUpButton.layer.borderWidth = 1
    }
       
       @IBAction func LoginAction(_ sender: Any) {
           
           ref = Database.database().reference()
           
           let roofRef = FirebaseDatabase.Database.database().reference()
     
        if AccessToken.isCurrentAccessTokenActive {
            self.performSegue(withIdentifier: "ToPhoto", sender: self)
        }
        
       
        
        Auth.auth().signIn(withEmail: usernameTxtFld.text!, password: passwordTxtFld.text!) { (authResult, error) in
            if((authResult) != nil) {
            self.performSegue(withIdentifier: "ToPhoto", sender: self)
            } else {
                self.errorText.isHidden = false
            }
        }
    }
  
    func signInGoogle(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
}
