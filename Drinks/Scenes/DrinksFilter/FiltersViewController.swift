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

    var categories: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }

    private func setupSubviews() {
        filtersTableView.dataSource = self
        filtersTableView.register(UINib(nibName: filterCellId, bundle: nil), forCellReuseIdentifier: filterCellId)
    }
    
}


extension FiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: filterCellId) as? FilterCell else { return UITableViewCell() }

        // TODO: State
        cell.setup(withName: categories[indexPath.row], state: true)
        
        return cell
    }
}
