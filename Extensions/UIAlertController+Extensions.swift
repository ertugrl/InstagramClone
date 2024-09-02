//
//  UIAlertController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 29.08.2024.
//

import UIKit

extension UIAlertController {
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}


//private func makeAlert(titleInput: String, messageInput: String) {
//    let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
//    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
//    alert.addAction(okButton)
//    present(alert, animated: true, completion: nil)
//}
