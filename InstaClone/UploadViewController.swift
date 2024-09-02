//
//  UploadViewController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 8.08.2024.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

final class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    // Flag to check if an image is selected
    private var isImageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            isImageSelected = true // Image has beeen selected
        }
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func uploadActionClicked(_ sender: UIButton) {
//        guard imageView.image != UIImage(named: "Image") else {
//            UIAlertController.showAlert(on: self, title: "Error", message: "Please select an image to upload.")
//            return
//        }
//        
//        let storage = Storage.storage()
//        let storageReference = storage.reference()
//        
//        // Specific folder in Firebase Storage
//        let mediaFolder = storageReference.child("media")
//        
//        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
//            let uuid = UUID().uuidString
//            
//            let imageReference = mediaFolder.child("\(uuid).jpg")
//            imageReference.putData(data) { metadata, error in
//                if let error = error {
//                    UIAlertController.showAlert(on: self, title: "Error", message: error.localizedDescription)
//                } else {
//                    imageReference.downloadURL { url, error in
//                        if error == nil {
//                            let imageUrl = url?.absoluteString
//                            
//                            
//                            // DATABASE
//                            
//                            let firestoreDatabase = Firestore.firestore()
//                            
//                            var firestoreReference: DocumentReference? = nil
//                            
//                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
//                            
//                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
//                                if let error = error {
//                                    UIAlertController.showAlert(on: self, title: "Error", message: error.localizedDescription)
//                                } else {
//                                    self.tabBarController?.selectedIndex = 0 // Move to "Feed" page
//                                    self.imageView.image = UIImage(named: "Image") // Return the default image
//                                    self.commentText.text = ""
//                                }
//                            })
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    @IBAction func uploadActionClicked(_ sender: UIButton) {
        guard isImageSelected else {
            UIAlertController.showAlert(on: self, title: "Error", message: "Please select an image to upload.")
            return
        }
        
        guard let imageData = prepareImageData() else {
            UIAlertController.showAlert(on: self, title: "Error", message: "Image data is not available.")
            return
        }
        
        uploadImageToStorage(imageData)
    }
    
    // Prepare the image data for upload
    private func prepareImageData() -> Data? {
        return imageView.image?.jpegData(compressionQuality: 0.5)
    }
    
    // Upload the image to Firebase Storage
    private func uploadImageToStorage(_ data: Data) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        let uuid = UUID().uuidString
        let imageReference = mediaFolder.child("\(uuid).jpg")
        
        imageReference.putData(data) { [weak self] metadata, error in
            guard let self else { return }
            
            if let error = error {
                UIAlertController.showAlert(on: self, title: "Error", message: error.localizedDescription)
                return
            }
            
            imageReference.downloadURL { url, error in
                guard let url = url, error == nil else {
                    UIAlertController.showAlert(on: self, title: "Error", message: error?.localizedDescription ?? "Error fetching download URL.")
                    return
                }
                self.savePostDataToFirestore(imageUrl: url.absoluteString)
            }
        }
    }
    
    // Save post data to Firestore
    private func savePostDataToFirestore(imageUrl: String) {
        let firestoreDatabase = Firestore.firestore()
        let firestorePost = [
            "imageUrl": imageUrl,
            "postedBy": Auth.auth().currentUser!.email!,
            "postComment": self.commentText.text ?? "",
            "date": FieldValue.serverTimestamp(),
            "likes": 0
        ] as [String: Any]
        
        firestoreDatabase.collection("Posts").addDocument(data: firestorePost) { [weak self] error in
            guard let self else { return }
            
            if let error = error {
                UIAlertController.showAlert(on: self, title: "Error", message: error.localizedDescription)
                return
            }
            
            self.resetUIAfterUpload()
        }
    }
    
    // Reset UI after successful upload
    private func resetUIAfterUpload() {
        self.tabBarController?.selectedIndex = 0 // Move to "Feed" page
        self.imageView.image = UIImage(named: "Image") // Return to default image
        self.commentText.text = ""
    }
}
