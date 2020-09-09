//
//  DrinksFilterViewController.swift
//  Drinks
//
//  Created by Philip on 09.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
 
    @IBOutlet weak var filtersTableView: UITableView!
    
    private var filterCellId: String { String(describing: FilterCell.self) }
    
    var delegate: DrinksViewControllerDelegate?
    
    var allCategories: [String] = []
    var selectedCategories: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupSubviews()
    }

    private func setupSubviews() {
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        filtersTableView.register(UINib(nibName: filterCellId, bundle: nil), forCellReuseIdentifier: filterCellId)
        
        title = "Filters"
    }
    
    @IBAction private func onApplyButtonTapped(_ sender: Any) {
        delegate?.filterApplied(withParameters: [.category : selectedCategories])
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension FiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: filterCellId) as? FilterCell else { return UITableViewCell() }

        let category = allCategories[indexPath.row]
        let isSelected = selectedCategories.contains(category)
        
        cell.setup(withName: category, state: isSelected)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = allCategories[indexPath.row]
        
        if let categoryIndex = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: categoryIndex)
        } else {
            selectedCategories.append(category)
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
