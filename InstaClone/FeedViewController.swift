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

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
//    var userEmailArray = [String]()
//    var userCommantArray = [String]()
//    var likeArray = [Int]()
//    var userImageArray = [String]()
//    var documentIDArray = [String]()
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.posts.removeAll(keepingCapacity: true)
                    
                    for document in snapshot!.documents {
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
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        let post = posts[indexPath.row]
        
        cell.userEmailLabel.text = post.userEmail
        cell.likeLabel.text = String(post.likes)
        cell.commentLabel.text = post.comment
        cell.postImageView.sd_setImage(with: URL(string: post.imageUrl))
        cell.documentIDLabel.text = post.documentID
        
        return cell
    }
}
