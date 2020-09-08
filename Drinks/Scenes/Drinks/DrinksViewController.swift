//
//  DrinksViewController.swift
//  Drinks
//
//  Created by Philip on 07.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class DrinksViewController: BaseViewController {
    
    @IBOutlet private weak var drinksTableView: UITableView!
    
    typealias DrinksGroupedByCategory = [([Drink], String)]
    
    private var drinksAll: [Drink] = []
    private var drinks: DrinksGroupedByCategory = []
    private var categories: [DrinkCategory] = []
    
    private var drinkCellId: String { String(describing: DrinkCell.self) }
    
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        fetchDrinks()
        fetchCategories()
    }
    
    // MARK: setup methods

    private func setupSubviews() {
        drinksTableView.dataSource = self
        drinksTableView.register(UINib(nibName: "DrinkCell", bundle: nil), forCellReuseIdentifier: "DrinkCell")
    }
    
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
    
    // MARK: data fetching methods
    
    private func fetchDrinks() {
        ApiService.getDrinks(byCategory: "Ordinary Drink") { [weak self] result in
            switch result {
            case .success(let drinks):
                guard let fetchedDrinks = drinks.drinks else { return }
                self?.drinksAll = fetchedDrinks
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func fetchCategories() {
        ApiService.getDrinksCategories() { [weak self] result in
            switch result {
            case .success(let categories):
                guard let fetchedCategories = categories.categories else { return }
                self?.categories = fetchedCategories
                print(categories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension DrinksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        drinks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        drinks[section].1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks[section].0.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell") as? DrinkCell else { return UITableViewCell() }
        
//        let title = drinks[indexPath.row].strDrink
//        let imageUrlString = drinks[indexPath.row].strDrinkThumb
//
//        cell.setup(withName: title, imageUrlString: imageUrlString)
        
        return cell
    }
    
}
