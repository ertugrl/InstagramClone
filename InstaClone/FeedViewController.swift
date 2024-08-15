//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 8.08.2024.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = "user@gmail.com"
        cell.likeLabel.text = "5"
        cell.commentLabel.text = "My comment."
        cell.postImageView.image = UIImage(named: "Image")
        
        return cell
    }
    

}
