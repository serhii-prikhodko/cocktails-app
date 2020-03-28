//
//  CategoriesPresenter.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/26/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation
import UIKit

protocol CategoriesDelegate {
    func displayCategories(categories: CategoriesList)
}

class CategoriesPresenter {
    var categoriesDelegate: CategoriesDelegate!
    
    init(with view: CategoriesDelegate) {
        self.categoriesDelegate = view
    }
    
    func loadCategoriesList() {
        NetworkService.fetchCategories() { (categories: CategoriesList?, error: Error?) in
            if let categories = categories {
                DispatchQueue.main.async {
                    self.categoriesDelegate.displayCategories(categories: categories)
                }
            } else if error != nil {
                print("ERROR: \(error!.localizedDescription)")
            }
        }
    }
   
}
