//
//  FilterCell.swift
//  Drinks
//
//  Created by Philip on 09.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet private weak var filterLabel: UILabel!
    @IBOutlet private weak var checkBoxImage: UIImageView!
    
    var isFilterSelected: Bool = true {
        didSet {
            checkBoxImage.isHidden = !isFilterSelected
        }
    }
    
    
    func setup(withName name: String, state: Bool) {
        filterLabel.text = name
        isFilterSelected = state
    }
}
