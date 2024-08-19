//
//  ViewController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 7.08.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func signInClicked(_ sender: UIButton) {
        // WOULD IT BE MEANINGFUL IF WE USED "guard"???
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Unknown Error")
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(identifier: "tabBarMenu") as! UITabBarController
                    
                    // Present the Tab Bar Controller modally
//                    tabBarVC.modalPresentationStyle = .fullScreen
//                    self.present(tabBarVC, animated: true, completion: nil)
                    self.navigationController?.pushViewController(tabBarVC, animated: true)
                }
            }
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let settingsVC = storyboard.instantiateViewController(identifier: "settings")
//        navigationController?.pushViewController(settingsVC, animated: true)
                
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Unknown Error")
                } else { // If sign up successfully
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarVC = storyboard.instantiateViewController(identifier: "tabBarMenu") as! UITabBarController
                    
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true, completion: nil)
                }
            }
            
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
}
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: "Error", message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}



