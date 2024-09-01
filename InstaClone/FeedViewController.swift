//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 8.08.2024.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import SDWebImageMapKit

final class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Required for enable the commend line to be multiple line
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        getDataFromFirestore()
    }
    
//    func getDataFromFirestore() {
//        let firestoreDatabase = Firestore.firestore()
//        
//        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
//            if error != nil {
//                print(error?.localizedDescription ?? "Error")
//            } else {
//                if snapshot?.isEmpty != true && snapshot != nil {
//                    
//                    self.posts.removeAll(keepingCapacity: true)
//                    
//                    for document in snapshot!.documents {
//                        let documentID = document.documentID
//                        
//                        if let postedBy = document.get("postedBy") as? String,
//                           let postComment = document.get("postComment") as? String,
//                           let likes = document.get("likes") as? Int,
//                           let imageUrl = document.get("imageUrl") as? String {
//                            let post = Post(userEmail: postedBy, comment: postComment, likes: likes, imageUrl: imageUrl, documentID: documentID)
//                            self.posts.append(post)
//                        }
//                    }
//                    
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
    
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { [weak self] snapshot, error in
            guard let self else { return }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let snapshot = snapshot, !snapshot.isEmpty else { return }
            
            self.posts.removeAll()
            for document in snapshot.documents {
                let documentID = document.documentID
                
                if let postedBy = document.get("postedBy") as? String,
                   let postComment = document.get("postComment") as? String,
                   let likes = document.get("likes") as? Int,
                   let imageUrl = document.get("imageUrl") as? String {
                    let post = Post(userEmail: postedBy, comment: postComment, likes: likes, imageUrl: imageUrl, documentID: documentID)
                    self.posts.append(post)
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        let post = posts[indexPath.row]
        
        cell.setPost(post)
        
        return cell
    }
}
