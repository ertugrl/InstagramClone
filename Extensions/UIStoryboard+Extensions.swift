//
//  UIStoryboard.swift
//  InstaClone
//
//  Created by Ertuğrul Şahin on 28.08.2024.
//

import UIKit

extension UIStoryboard {
    static func getMainStoryboard(_ identifier: String) -> UIViewController {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: identifier)
    }
}
