//
//  DrinkCategoryModel.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation

struct DrinkCategories: Codable {
    var categories: [DrinkCategory]?
    
    private enum CodingKeys: String, CodingKey {
        case categories = "drinks"
    }
}

struct DrinkCategory: Codable {
    var strCategory: String?
}
