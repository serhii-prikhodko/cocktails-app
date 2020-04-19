//
//  DrinksTableViewController.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    // MARK: - Properties
    var currentCategoryIndex = 0
    var categories = [Category]()
    var loadedCategories = [Category]()
    var cocktailsInSections = [[Cocktail]]()
    lazy var presenter = CocktailsPresenter(with: self)
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set properties for activity indicator
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
        
        let error = self.presenter.loadCategoriesList()
        self.activityIndicatorView.stopAnimating()
        if let error = error {
            self.showAlert(title: "Warning", message: error.localizedDescription, style: .alert)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return loadedCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.cocktailsInSections[section].count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = loadedCategories[section].strCategory
        label.backgroundColor = UIColor.lightGray

        return label
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCellID", for: indexPath) as! SingleDrinkTableViewCell

        cell.update(with: self.cocktailsInSections[indexPath.section][indexPath.row])
        
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            if indexPath.section != self.currentCategoryIndex {
                self.loadedCategories.append(self.categories[self.currentCategoryIndex])
                let error = self.presenter.loadCocktailsByCategory(category: self.loadedCategories[self.currentCategoryIndex])
                if let error = error {
                    self.showAlert(title: "Warning", message: error.localizedDescription, style: .alert)
                }
            } else {
                self.tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
    // MARK: - Additional functions
    func showAlert (title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController (title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func filterButtorPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "categoriesVC_ID") as! CategoriesTableViewController
        
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
// MARK: - Delegate functions
}
extension CocktailsTableViewController: TransferDelegate {
    func setSelectedCategories(_ categories: [Category]) {
        self.categories = categories
        self.loadedCategories = [Category]()
        self.cocktailsInSections = [[Cocktail]]()
        self.currentCategoryIndex = 0
        let error = self.presenter.loadCocktailsByCategory(category: self.categories[0])
        if let error = error {
            self.showAlert(title: "Warning", message: error.localizedDescription, style: .alert)
        }
        self.loadedCategories.append(self.categories[self.currentCategoryIndex])
    }
}
extension CocktailsTableViewController: CocktailDelegate {
    func displayCategoriesAndFirstCocktailsList(categories: CategoriesList, cocktails: CocktailList) {
        self.categories = categories.drinks
        self.loadedCategories.append(self.categories[self.currentCategoryIndex])
        self.cocktailsInSections.append(cocktails.drinks)
        self.currentCategoryIndex += 1
        tableView.reloadData()
    }
    
    func displayCocktailsForSelectedCategory(list: CocktailList) {
        self.cocktailsInSections.append(list.drinks)
        if self.currentCategoryIndex < self.categories.count - 1 {
            self.currentCategoryIndex += 1
        }
        tableView.reloadData()
    }
    
    func displayImageForCocktail(image: Data) {
    }
}
