//
//  DrinksPresenter.swift
//  Drinks
//
//  Created by Philip on 08.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

enum DrinksFilter {
    case category
}

class DrinksPresenter {
    typealias DrinksGroupedByCategory = [([Drink], String)]
    
    private let view: DrinksViewController
    
    // Downloaded data
    private var fetchedDrinks: DrinksGroupedByCategory = []
    private var fetchedCategories: [String] = []

    // Current data, modifying by user
    private var filteredDrinks: DrinksGroupedByCategory { getFilteredDrinks() }
    private var selectedCategories: [String] { filters[.category] as? [String] ?? [] }
    
    private var filters: [DrinksFilter: Any] = [:] {
        didSet {
            checkFilteringResult()
            view.reloadData()
        }
    }
    
    
    init(view: DrinksViewController) {
        self.view = view
        setupInitialData()
    }
    
    // MARK: - View interaction interface
    
    func getNumberOfGroups() -> Int {
        filteredDrinks.count
    }
    
    func getGroupName(in groupIndex: Int) -> String {
        filteredDrinks[groupIndex].1
    }
    
    func getNumberOfDrinksInGroup(in groupIndex: Int) -> Int {
        filteredDrinks[groupIndex].0.count
    }
    
    func getDrinkName(in groupIndex: Int, with index: Int) -> String {
        filteredDrinks[groupIndex].0[index].strDrink ?? ""
    }
    
    func getDrinkImage(in groupIndex: Int, with index: Int) -> String {
        filteredDrinks[groupIndex].0[index].strDrinkThumb ?? ""
    }
    
    func getSelectedCategories() -> [String] {
        selectedCategories
    }
    
    func getAllCategories() -> [String] {
        fetchedCategories
    }
    
    func setFilters(with newFilters: [DrinksFilter: Any]) {
        filters = newFilters
    }
    
    func checkShouldLoadNewCategory(section: Int, index: Int) {
        let isLastGroup = section == (getNumberOfGroups() - 1)
        let isLastDrink = index == (getNumberOfDrinksInGroup(in: section) - 1)
        let canLoadMoreCategories = getNumberOfGroups() < selectedCategories.count
        guard isLastGroup && isLastDrink else { return }
        
        if canLoadMoreCategories {
            let newCategoryName = selectedCategories[getNumberOfGroups()]
            loadDrinksForCategory(withName: newCategoryName)
        } else {
            // TODO: show alert
        }
    }
    
    // MARK: Private methods
    
    
    
    // MARK: - Data formating
    
    private func getFilteredDrinks() -> DrinksGroupedByCategory {        
        var filteredDrinks = fetchedDrinks
        
        for (filterType, value) in filters {
            switch filterType {
            case .category:
                guard let categories = value as? [String] else { continue }
                filteredDrinks = filteredDrinks.filter { categories.contains($0.1) }
            }
        }
        
        return filteredDrinks
    }
    
    private func getCategoriesList(from categories: [DrinkCategory]) -> [String] {
        var categoriesList: [String] = []
        
        categories.forEach { category in
            if let name = category.strCategory {
                categoriesList.append(name)
            }
        }
        return categoriesList
    }
    
    private func checkFilteringResult() {
        if filteredDrinks.isEmpty && !fetchedDrinks.isEmpty {
            guard let category = selectedCategories.first else { return }
            loadDrinksForCategory(withName: category)
        }
    }
    
    // MARK: - Data fetching-obtaining
    
    private func setupInitialData() {
        fetchCategories() { [weak self] categories in
            guard let strongSelf = self else { return }
            guard let categories = categories else { return }
            let categoriesList = strongSelf.getCategoriesList(from: categories)
            
            strongSelf.fetchedCategories = categoriesList
            strongSelf.filters[.category] = categoriesList
            
            guard let firstCategory = categoriesList.first else { return }
            
            strongSelf.fetchDrinks(byCategory: firstCategory) { drinks in
                guard let drinks = drinks else { return }
                
                strongSelf.fetchedDrinks.append((drinks, firstCategory))
                
                strongSelf.view.reloadData()
            }
        }
    }
    
    private func loadDrinksForCategory(withName: String) {
        fetchDrinks(byCategory: withName) { [weak self] fetchedDrinks in
            guard let fetchedDrinks = fetchedDrinks else { return }
            
            self?.fetchedDrinks.append((fetchedDrinks, withName))
            
            self?.view.reloadData()
        }
    }

}

// MARK: - API Methods

extension DrinksPresenter {
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
                self?.fetchedCategories = self?.getCategoriesList(from: fetchedCategories) ?? []
                completion(fetchedCategories)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
