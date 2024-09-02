//
//  SettingsViewController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 8.08.2024.
//

import UIKit
import FirebaseAuth

final class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // INCORRECT VERSION
//    @IBAction func logoutClicked(_ sender: UIButton) {
//        do {
//            try Auth.auth().signOut()
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let loginVC = storyboard.instantiateViewController(identifier: "login") as! ViewController
//            
//            loginVC.modalPresentationStyle = .fullScreen
//            dismiss(animated: true, completion: nil)
//        } catch {
//            print("Error")
//        }
//        
//        // !!!
////        navigationController?.pushViewController(loginVC, animated: true)
//        
//    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()

            // Set the login screen as the root view controller after logging out
            
            let loginVC = UIStoryboard.getMainStoryboard("login")
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = loginVC
                UIView.transition(with: window,
                                  duration: 0.5,
                                  options: [.transitionFlipFromRight],
                                  animations: nil,
                                  completion: nil)
            }
            
        } catch {
            print("Error signing out")
        }
        
        // !!!
//        navigationController?.pushViewController(loginVC, animated: true)
        
    }
}
