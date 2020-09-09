//
//  UINavigationController.swift
//  Drinks
//
//  Created by Philip on 09.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

extension UINavigationController {
    func dropShadow() {
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 4.0
        navigationBar.layer.shadowOpacity = 1.0
        navigationBar.layer.masksToBounds = false
    }
    
    func setupTitleFont() {
        UIFont.boldSystemFont(ofSize: 16.0)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0, weight: .medium)]
    }
    
    func setupAndroidBackImage() {
        let image = UIImage(named: "back")
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
        navigationBar.backItem?.title = ""
    }
}
