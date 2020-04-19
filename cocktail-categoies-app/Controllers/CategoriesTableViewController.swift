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
    var selectedCategories = [Category]()
    lazy var presenter = CategoriesPresenter(with: self)
    @IBOutlet weak var applyBarButton: UIBarButtonItem!
    var delegate: TransferDelegate?
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadCategoriesList()
        self.applyBarButton.isEnabled = false
    }
    
    // MARK: - Functions
    @IBAction func applyButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.setSelectedCategories(self.selectedCategories)
        
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
    // Add checkmark for selected cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkmarkAccessoryType = UITableViewCell.AccessoryType.checkmark
        let noneAccessoryType = UITableViewCell.AccessoryType.none
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == checkmarkAccessoryType {
            tableView.cellForRow(at: indexPath)?.accessoryType = noneAccessoryType
            self.selectedCategories = self.selectedCategories.filter { $0.strCategory != self.categories[indexPath.row].strCategory }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = checkmarkAccessoryType
            self.selectedCategories.append(self.categories[indexPath.row])
        }
        self.applyBarButton.isEnabled = true
    }
}

extension CategoriesTableViewController: CategoriesDelegate {
    func displayCategories(categories: CategoriesList) {
        self.categories = categories.drinks
        tableView.reloadData()
    }
}
