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
  //      print(GIDSignIn.sharedInstance()?.currentUser)
    }
    
    fileprivate var currentNonce: String?
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var fbButton: UIView!
    @IBOutlet weak var errorText: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    var ref: DatabaseReference!
    var isTrue = false
    
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
    
       
       func txtFldIsEmpty() {
           if usernameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" || passwordTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
               loginBtn.isEnabled = true
           }
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
        
        
        
        /*
        signInGoogle(email: usernameTxtFld.text!, pass: passwordTxtFld.text!) { (true) in
            self.performSegue(withIdentifier: "ToPhoto", sender: self)
        }
    */
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
    
    /*
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if AccessToken.isCurrentAccessTokenActive {
            performSegue(withIdentifier: "ToPhoto", sender: self)
        }
    }
    */
    /*
    @IBAction func logInBtnApple(_ sender: Any) {
    let button = ASAuthorizationAppleIDButton()
        button.center = view.center
        view.addSubview(button)
    }
    
    @objc func handleSignInWithAppleTapped() {
        performSignIn()
    }
    
    func performSignIn() {
        
    }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvicer = ASAuthorizationAppleIDProvider()
        let request = appleIDProvicer.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
      //  request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
       let hashedData = sha256(String(inputData))
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
 */
    
}
/*

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login requet was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToke else {
                print("Unable to fetch")
            }
        }
    }
}


extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
*/
