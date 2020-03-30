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
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadCategoriesList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                self.presenter.loadCocktailsByCategory(category: self.loadedCategories[self.currentCategoryIndex])
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
