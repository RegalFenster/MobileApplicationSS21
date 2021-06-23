//
//  LoginWindow.swift
//  MobileApplication
//
//  Created by Lukas Weber on 15.06.21.
//  Copyright © 2021 Lukas Weber. All rights reserved.
//

import UIKit
import Foundation
import FirebaseUI
import FirebaseAuth
import FirebaseDatabase

class Login: UIViewController {
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var nuber = 5
    var ref: DatabaseReference!
    
    @IBAction func LoginAction(_ sender: Any) {
       // var ref: DatabaseReference!

        ref = Database.database().reference()
        
    //    print(ref.child("Username").value(forKey: "Username"))
        
        let roofRef = FirebaseDatabase.Database.database().reference()
        
        let conditionRef = roofRef.child("Username")
        
        print(conditionRef)
        
        /*
        roofRef.child("Username").observeSingleEvent(of: .value, with: { (snapshot) in
        
 if snapshot.hasChild(usernameTxtFld.text) {
                print("logo")
            } else {
                print("fail")
            }
 
        })
 */
        
        /*
        self.ref.child("users/\(user.uid)/username").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
            }
            else {
                print("No data available")
            }
        }
        
        
    
    var actionCodeSettings = ActionCodeSettings()
    actionCodeSettings.url = URL(string: "https://example.appspot.com")
    actionCodeSettings.handleCodeInApp = true
    actionCodeSettings.setAndroidPackageName("com.firebase.example", installIfNotAvailable: false, minimumVersion: "12")
         */
        /*
     let provider = FUIEmailAuth(authUI: FUIAuth.defaultAuthUI()!,
                                signInMethod: FIREmailLinkAuthSignInMethod,
                                forceSameDevice: false,
                                allowNewEmailAccounts: true,
                                actionCodeSetting: actionCodeSettings)
        */
            }
    
    
    
}
