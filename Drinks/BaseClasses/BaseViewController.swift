//
//  BaseViewController.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var presenter: BasePresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPresenter()
    }
    
    private func initPresenter() {
        
    }
}
