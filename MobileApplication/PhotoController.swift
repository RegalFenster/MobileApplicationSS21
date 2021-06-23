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

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageData: UIImageView!
    
    private let storage = Storage.storage().reference()
    
    let storageRef = Storage.storage().reference()
    
    @IBAction func uploadButton(_ sender: UIButton) {
       let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
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
    
    
    @IBAction func showData(_ sender: Any) {
        
        let random = Int.random(in: 1...10)
       let storageReference = Storage.storage().reference().child("images/file\(random).png")
     //   let storageReference = Storage.
        storageReference.listAll { (result, error) in
          if let error = error {
            // ...
          }
          for prefix in result.prefixes {
            // The prefixes under storageReference.
            // You may call listAll(completion:) recursively on them.
          }
          for item in result.items {
            // The items under storageReference.
          }
        }
    }
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

   
