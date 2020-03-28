//
//  CategoriesPresenter.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/26/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

protocol CategoriesDelegate: class {
    func displayDrinks(categories: CategoriesList)
}

class CategoriesPresenter {
    weak var categoriesDelegate: CategoriesDelegate!
    
    init(with view: CategoriesDelegate) {
        self.categoriesDelegate = view
    }
    
    func loadCategoriesList() {
        NetworkService.fetchCategories() { (categories: CategoriesList?, error: Error?) in
            if let categories = categories {
                DispatchQueue.main.async {
                    self.categoriesDelegate.displayDrinks(categories: categories)
                }
            } else if error != nil {
                print("ERROR: \(error!.localizedDescription)")
            }
        }
    }
   
}
