//
//  DrinkModel.swift
//  Drinks
//
//  Created by Philip on 07.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation

struct Drinks: Codable {
    let drinks: [Drink]?
}

struct Drink: Codable {
    let strDrink: String?
    let strDrinkThumb: String?
    let idDrink: String?
    let strCategory: String?
}
