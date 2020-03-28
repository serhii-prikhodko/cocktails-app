//
//  DrinksPresenter.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

protocol CocktailDelegate {
    func displayCategories(categories: CategoriesList)
    func displayCocktailsForSelectedCategory(list: CocktailList)
    func displayImageForCocktail(image: Data)
}

class CocktailsPresenter {
    var cocktailsDelegate: CocktailDelegate!
    
    init(with view: CocktailDelegate) {
        self.cocktailsDelegate = view
    }
    func loadCategoriesList() {
        NetworkService.fetchCategories() { (categories: CategoriesList?, error: Error?) in
            if let categories = categories {
                DispatchQueue.main.async {
                    self.cocktailsDelegate.displayCategories(categories: categories)
                }
            } else if error != nil {
                print("ERROR: \(error!.localizedDescription)")
            }
        }
    }
    func loadCocktailsByCategory(category: Category) {
        NetworkService.fetchCocktailsByCategory(category: category) { (cocktailList: CocktailList?, error: Error?) in
            if let cocktailList = cocktailList {
                DispatchQueue.main.async {
                    self.cocktailsDelegate.displayCocktailsForSelectedCategory(list: cocktailList)
                }
            } else if error != nil {
                print("ERROR: \(error!.localizedDescription)")
            }
        }
    }
    func loadImageForCocktail(cocktail: Cocktail) {
        NetworkService.fetchCocktailImage(cocktail: cocktail, completionHandler: {(data: Data?) in
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    self?.cocktailsDelegate.displayImageForCocktail(image: data)
                }
            }
        })
    }
}
