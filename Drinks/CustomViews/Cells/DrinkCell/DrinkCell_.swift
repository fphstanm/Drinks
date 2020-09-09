//
//  DrinkCell.swift
//  Drinks
//
//  Created by Philip on 07.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit
import Kingfisher

class DrinkCell: UITableViewCell {
    @IBOutlet private weak var drinkName: UILabel!
    @IBOutlet private weak var drinkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    func setup() {
        let view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "collectionItemCollectionViewCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    
    func setup(withTitle: String?, imageUrlString: String?) {
//        drinkName.text = withTitle
        
//        guard let imageUrl = URL(string: imageUrlString ?? "") else { return }
//        drinkImage.kf.setImage(with: imageUrl)
    }
}
