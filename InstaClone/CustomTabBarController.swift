//
//  CustomTabBarController.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 30.08.2024.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of view controllers
        let feedVC = UIStoryboard.getMainStoryboard("feed")
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag: 0)
        
        let uploadVC = UIStoryboard.getMainStoryboard("upload")
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "square.and.arrow.up"), tag: 1)
        
        let settingsVC = UIStoryboard.getMainStoryboard("settings")
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        // Set the view controllers of the tab bar
        self.viewControllers = [feedVC, uploadVC, settingsVC]
    }
}
