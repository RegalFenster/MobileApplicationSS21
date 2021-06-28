//
//  ViewController.swift
//  MobileApplication
//
//  Created by Lukas Weber on 14.06.21.
//  Copyright © 2021 Lukas Weber. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var vornameOutlet: UITextField!
    @IBOutlet weak var nachnameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    //    let ref = Database.database().reference()
        
     
        submitButtonLook()
        
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
    
        let ref = Database.database().reference()
        
        ref.childByAutoId().setValue(["Vorname":vornameOutlet.text, "Nachname":nachnameOutlet.text, "Email":emailOutlet.text, "Passwort":passwordOutlet.text])
        
       
        
        Auth.auth().createUser(withEmail: emailOutlet.text!, password: passwordOutlet.text!) { (result, error) in
     
          
            
            if error != nil {
            
                print("Error creating User")
               
            } else {
                
            }
        }
        
        
    }
    
    func submitButtonLook() {
           submitButton.tintColor = UIColor(red: 5/255, green: 126/255, blue: 255/255, alpha: 1)
           submitButton.layer.cornerRadius = 5
           submitButton.layer.borderColor = UIColor(red: 5/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
           submitButton.layer.borderWidth = 1
       }
    
}






















