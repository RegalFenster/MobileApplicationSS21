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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    //    let ref = Database.database().reference()
        
     
        
        
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
    
    
    
}






















