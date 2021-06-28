//
//  MainMenu.swift
//  MobileApplication
//
//  Created by Lukas Weber on 14.06.21.
//  Copyright © 2021 Lukas Weber. All rights reserved.
//

import UIKit
import Foundation
import FirebaseStorage
import FirebaseUI
import GoogleSignIn
import FirebaseAuth

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GIDSignInDelegate {
   
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        return
    }
    
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var backButtonAction: UIButton!
    @IBOutlet weak var pullButtonOutlet: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    
    
    private let storage = Storage.storage().reference()
 
    
    @IBAction func signOut(_ sender: Any) {
        GIDSignIn.sharedInstance()?.disconnect()
        do{
        try Auth.auth().signOut()
        } catch {
            
        }
    }
   
    override func viewDidLoad() {
        buttonLook(button: pullButtonOutlet)
        buttonLook(button: deleteButtonOutlet)
    }
    
    func buttonLook(button: UIButton) {
        button.tintColor = UIColor(red: 5/255, green: 126/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(red: 5/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
       }
    
    
    @IBAction func uploadButton(_ sender: UIButton) {
       let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
        let random = Int.random(in: 1...10)
        let storageReference = Storage.storage().reference().child("images/file\(random).png")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
        
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        let random = Int.random(in: 1...10)
              let storageReference = Storage.storage().reference().child("images/file\(random).png")
        
        storage.child("images/file.png").putData(imageData, metadata: nil, completion:{_, error in
            guard error == nil else {
                print("Failed ot upload")
                return
            }
            
            self.storage.child("images/file.png").downloadURL(completion: {url,error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
    }

    
    @IBAction func downloadPicture(_ sender: UIButton) {
        let storageRef = Storage.storage().reference()
        
        let ref = storageRef.child("images/file.png")
        
        imageData.sd_setImage(with: ref)
        imageData.backgroundColor = .clear
  
    }
    
    @IBAction func deleteImage(_ sender: Any) {
        
        let storageRef = Storage.storage().reference()
        
        let desertRef = storageRef.child("images/file.png")

        // Delete the file
        desertRef.delete { error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // File deleted successfully
          }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

   
