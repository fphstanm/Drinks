//
//  NavigationController.swift
//  Drinks
//
//  Created by Philip on 09.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//


import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropShadow()
        setupTitleFont()
        setupAndroidBackImage()
        
        navigationBar.tintColor = .black
        navigationBar.barTintColor = .white
    }
    
}
