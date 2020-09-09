//
//  BaseViewController.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var presenter: BasePresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPresenter()
    }
    
    func initPresenter() {
        
    }
}
