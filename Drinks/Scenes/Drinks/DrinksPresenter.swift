//
//  DrinksPresenter.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

struct DrinksViewControllerParameters {

}

class DrinksPresenter: BasePresenter {
    typealias DrinksGroupedByCategory = [([Drink], String)]
    
    var drinks: DrinksGroupedByCategory = []
    var categories: [DrinkCategory] = []
    
    
//    override init(initialView: DrinksViewController) {
//        super.init(initialView: initialView)
//    }
    
    private func formGroupedDrinks(with list: [Drink]) -> DrinksGroupedByCategory {
        var groupedList: DrinksGroupedByCategory = []
        
        for drink in list {
            guard let drinkCategory = drink.strCategory else { continue }
            guard !groupedList.isEmpty else { groupedList.append(([drink], drinkCategory)); continue }
            
            for (groupIndex, (_, category)) in groupedList.enumerated() {
                if drinkCategory == category {
                    groupedList[groupIndex].0.append(drink)
                } else {
                    groupedList.append(([drink], category))
                }
            }
        }
        
        return groupedList
    }
}
