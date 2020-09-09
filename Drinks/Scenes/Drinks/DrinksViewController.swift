//
//  DrinksViewController.swift
//  Drinks
//
//  Created by Philip on 07.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

protocol DrinksViewControllerDelegate {
    func filterApplied(withParameters parameters: [DrinksFilter: Any])
}

class DrinksViewController: UIViewController {
    
    @IBOutlet private weak var drinksTableView: UITableView!
    
    private var drinkCellId: String { String(describing: DrinkCell.self) }
    
    private var presenter: DrinksPresenter!
    
    var delegate: DrinksViewControllerDelegate?
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupSubviews()
    }
    
    // MARK: Public methods / presenter interacion
    
    func reloadData() {
        drinksTableView.reloadData()
    }
    
    // MARK: - Setup methods

    private func setup() {
        presenter = DrinksPresenter(view: self)
        delegate = self
    }
    
    private func setupSubviews() {
        drinksTableView.dataSource = self
        drinksTableView.delegate = self
        drinksTableView.register(UINib(nibName: drinkCellId, bundle: nil), forCellReuseIdentifier: drinkCellId)
        
        title = "Drinks"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: 
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFiltersScreen" {
            guard let filtersViewController = segue.destination as? FiltersViewController else { return }
            let categories = presenter.getSelectedCategories()
            let allCategories = presenter.getAllCategories()
            
            filtersViewController.allCategories = allCategories
            filtersViewController.selectedCategories = categories
            filtersViewController.delegate = self
        }
    }
    
}

// MARK: - UITableViewDataSource

extension DrinksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getNumberOfGroups()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.getGroupName(in: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfDrinksInGroup(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: drinkCellId) as? DrinkCell else { return UITableViewCell() }
        
        let title = presenter.getDrinkName(in: indexPath.section, with: indexPath.row)
        let imageUrlString = presenter.getDrinkImage(in: indexPath.section, with: indexPath.row)

        cell.setup(withName: title, imageUrlString: imageUrlString)
        
        return cell
    }
    
    

}

// MARK: - UITableViewDelegate

extension DrinksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.checkShouldLoadNewCategory(section: indexPath.section, index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        header.textLabel?.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let view = UIView()
        view.backgroundColor = .white
        header.backgroundView = view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        56.0
    }
}


// MARK: - DrinksViewControllerDelegate

extension DrinksViewController: DrinksViewControllerDelegate {
    func filterApplied(withParameters parameters: [DrinksFilter : Any]) {
        presenter.setFilters(with: parameters)
    }
}
