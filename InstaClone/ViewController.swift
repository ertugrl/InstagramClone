//
//  ViewController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 7.08.2024.
//

import UIKit
import FirebaseAuth

final class ViewController: UIViewController {
    
    @IBOutlet private weak var emailText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!

    @IBAction private func signInClicked(_ sender: UIButton) {
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty else {
            UIAlertController.showAlert(on: self, title: "Error", message: "Username/Password?")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authdata, error in
            guard let self = self else { return }
            
            if let error = error {
                UIAlertController.showAlert(on: self, title: "Error", message: error.localizedDescription)
                return
            }
            
            
            guard let window = self.view.window else { return }
            let tabBarVC = UIStoryboard.getMainStoryboard("tabBarMenu")
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
        
        
        // BEFORE THE CHANGE
//        if emailText.text != "" && passwordText.text != "" {
//            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
//                if error != nil {
//                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Unknown Error")
//                } else {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let tabBarVC = storyboard.instantiateViewController(identifier: "tabBarMenu") as! UITabBarController
//
//                    self.view.window?.rootViewController = tabBarVC
//                    self.view.window?.makeKeyAndVisible()
//                }
//            }
//        } else {
//            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
//        }
    }
    
    @IBAction private func signUpClicked(_ sender: UIButton) {
        guard let email = emailText.text, email.isEmpty, let password = passwordText.text, password.isEmpty else {
            UIAlertController.showAlert(on: self, title: "Error", message: "Username/Password?")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authdata, error in
            guard let self else { return }
            if let error = error {
                UIAlertController.showAlert(on: self, title: "Error", message: error.localizedDescription)
                return
            }
            guard let window = self.view.window else { return }
            let tabBarVC = UIStoryboard.getMainStoryboard("tabBarMenu")
            
            window.rootViewController = tabBarVC
            window.makeKeyAndVisible()
        }
        
        // BEFORE THE CHANGE
//        if emailText.text != "" && passwordText.text != "" {
//            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
//                if error != nil {
//                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Unknown Error")
//                } else { // If sign up successfully
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let tabBarVC = storyboard.instantiateViewController(identifier: "tabBarMenu") as! UITabBarController
//                    
//                    tabBarVC.modalPresentationStyle = .fullScreen
//                    self.present(tabBarVC, animated: true, completion: nil)
//                }
//            }
//            
//        } else {
//            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
//        }
    }
    
//    private func makeAlert(titleInput: String, messageInput: String) {
//        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
//        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
//        alert.addAction(okButton)
//        present(alert, animated: true, completion: nil)
//    }
}
