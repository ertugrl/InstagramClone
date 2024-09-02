//
//  SceneDelegate.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 7.08.2024.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    // MARK: Properties
    var window: UIWindow?

    // MARK: Functions
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // Check if user is logged in
        if Auth.auth().currentUser != nil {
            // User is logged in, show the tab bar controller
            window.rootViewController = CustomTabBarController()
        } else {
            // User is not logged in, show the login/sign-up page
            window.rootViewController = UIStoryboard.getMainStoryboard("login")
        }
        
        // BEFORE PROGRAMATIC TABBARCONTROLLER
//        let vcIdentifier = Auth.auth().currentUser != nil ? "tabBarMenu" : "login"
//        let rootVC = UIStoryboard.getMainStoryboard(vcIdentifier)
//        window.rootViewController = rootVC
        
        window.makeKeyAndVisible()
        self.window = window
    }
}
