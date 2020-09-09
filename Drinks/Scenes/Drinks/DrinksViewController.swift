//
//  DrinksViewController.swift
//  Drinks
//
//  Created by Philip on 07.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {
    
    @IBOutlet private weak var drinksTableView: UITableView!
    
    private var drinkCellId: String { String(describing: DrinkCell.self) }
    
    private var presenter: DrinksPresenter!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = DrinksPresenter(view: self)
        setupSubviews()
    }
    
    // MARK: Public methods / presenter interacion
    
    func reloadTableView() {
        drinksTableView.reloadData()
    }
    
    // MARK: Setup methods

    private func setupSubviews() {
        drinksTableView.dataSource = self
        drinksTableView.delegate = self
        drinksTableView.register(UINib(nibName: drinkCellId, bundle: nil), forCellReuseIdentifier: drinkCellId)
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
}

