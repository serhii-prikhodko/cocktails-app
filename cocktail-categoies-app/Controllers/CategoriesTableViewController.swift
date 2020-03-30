//
//  CategoriesTableViewController.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/26/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var categories = [Category]()
    lazy var presenter = CategoriesPresenter(with: self)
    
    // MARK: - Life circle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadCategoriesList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCellID", for: indexPath) as! CategoryTableViewCell

        cell.update(with: self.categories[indexPath.row])

        return cell
    }
}

extension CategoriesTableViewController: CategoriesDelegate {
    func displayCategories(categories: CategoriesList) {
        self.categories = categories.drinks
        tableView.reloadData()
    }
}
