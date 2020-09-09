//
//  DrinksPresenter.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class DrinksPresenter {
    typealias DrinksGroupedByCategory = [([Drink], String)]
    
    private let view: DrinksViewController
    
    private var drinks: DrinksGroupedByCategory = []
    var categories: [DrinkCategory] = []
    
    
    init(view: DrinksViewController) {
        self.view = view
        setupInitialData()
    }
    
    //MARK: - Public methods / view interaction
    
    // MARK: getters
    
    func getNumberOfGroups() -> Int {
        drinks.count
    }
    
    func getGroupName(in groupIndex: Int) -> String {
        drinks[groupIndex].1
    }
    
    func getNumberOfDrinksInGroup(in groupIndex: Int) -> Int {
        drinks[groupIndex].0.count
    }
    
    func getDrinkName(in groupIndex: Int, with index: Int) -> String {
        drinks[groupIndex].0[index].strDrink ?? ""
    }
    
    func getDrinkImage(in groupIndex: Int, with index: Int) -> String {
        drinks[groupIndex].0[index].strDrinkThumb ?? ""
    }
    
    func checkShouldLoadNewCategory(section: Int, index: Int) {
        let isLastGroup = section == (getNumberOfGroups() - 1)
        let isLastDrink = index == (getNumberOfDrinksInGroup(in: section) - 1)
        let canLoadMoreCategories = getNumberOfGroups() < categories.count
        guard isLastGroup && isLastDrink else { return }
        
        guard let newCategoryName = categories[getNumberOfGroups()].strCategory else { return }
        
        if canLoadMoreCategories {
            loadNextCategoryOfDrinks(withName: newCategoryName)
        } else {
            // TODO: show alert
        }
    }
    
    // MARK: - Private methods
    
    // MARK: Data manipulation methods
    
    private func setupInitialData() {
        fetchCategories() { [weak self] categories in
            guard let categories = categories else { return }
            self?.categories = categories
            
            guard let firstCategory = categories.first?.strCategory else { return }
            
            self?.fetchDrinks(byCategory: firstCategory) { drinks in
                guard let drinks = drinks else { return }
                
                self?.drinks.append((drinks, firstCategory))
                
                self?.view.reloadTableView()
            }
        }
    }
    
    private func loadNextCategoryOfDrinks(withName name: String) {
        fetchDrinks(byCategory: name) { [weak self] fetchedDrinks in
            guard let fetchedDrinks = fetchedDrinks else { return }
            
            self?.drinks.append((fetchedDrinks, name))
            
            self?.view.reloadTableView()
        }
    }

    // MARK: API methods
    
    private func fetchDrinks(byCategory: String, completion: @escaping ([Drink]?) -> Void) {
        ApiService.getDrinks(byCategory: byCategory) { result in
            switch result {
            case .success(let drinks):
                guard let fetchedDrinks = drinks.drinks else { return }
                completion(fetchedDrinks)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
        
    }
    
    private func fetchCategories(completion: @escaping ([DrinkCategory]?) -> Void) {
        ApiService.getDrinksCategories() { [weak self] result in
            switch result {
            case .success(let categories):
                guard let fetchedCategories = categories.categories else { return }
                self?.categories = fetchedCategories
                completion(fetchedCategories)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }

}
