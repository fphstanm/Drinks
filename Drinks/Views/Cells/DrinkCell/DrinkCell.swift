//
//  DrinksCell.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit
import Kingfisher

class DrinkCell: UITableViewCell {
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    func setup(withName: String?, imageUrlString: String?) {
        drinkNameLabel.text = withName
        
        guard let imageUrl = URL(string: imageUrlString ?? "") else { return }
        drinkImageView.kf.setImage(with: imageUrl)
    }
}
