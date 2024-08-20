//
//  Post.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 20.08.2024.
//

import Foundation

class Post {
    var userEmail: String
    var comment: String
    var likes: Int
    var imageUrl: String
    var documentID: String
    
    init(userEmail: String, comment: String, likes: Int, imageUrl: String, documentID: String) {
        self.userEmail = userEmail
        self.comment = comment
        self.likes = likes
        self.imageUrl = imageUrl
        self.documentID = documentID
    }
}
