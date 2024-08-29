//
//  FeedCell.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 15.08.2024.
//

import UIKit
import FirebaseFirestore

class FeedCell: UITableViewCell {

    // MARK: UI Elements
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    private var documentID: String?
    
    func setPost(_ post: Post) {
        postImageView.sd_setImage(with: URL(string: post.imageUrl))
        userEmailLabel.text = post.userEmail
        commentLabel.text = post.comment
        likeLabel.text = String(post.likes)
        documentID = post.documentID
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        guard let likeText = likeLabel.text, let likeCount = Int(likeText),
              let documentID = documentID else {
//            UIAlertController.showAlert(on: self, title: "Error", message: "Unable to retrieve like count or document ID.")
            return
        }
        
        let likeStore = ["likes": likeCount + 1] as [String : Any]
        Firestore.firestore().collection("Posts").document(documentID).setData(likeStore, merge: true)
        
        // BEFORE THE CHANGES
//        let firestoreDatabase = Firestore.firestore()
//        if let likeCount = Int(likeLabel.text!) {
//            let likeStore = ["likes" : likeCount + 1] as [String : Any]
//            firestoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true)
//        }
    }
}
