//
//  DrinksPresenter.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

protocol CocktailDelegate {
    func displayCategoriesAndFirstCocktailsList(categories: CategoriesList, cocktails: CocktailList)
    func displayCocktailsForSelectedCategory(list: CocktailList)
    func displayImageForCocktail(image: Data)
}

class CocktailsPresenter {
    var cocktailsDelegate: CocktailDelegate!
    
    init(with view: CocktailDelegate) {
        self.cocktailsDelegate = view
    }
    func loadCategoriesList() -> Error? {
        var haveError: Error?
        NetworkService.fetchCategories() { (categories: CategoriesList?, error: Error?) in
            if let categories = categories {
                let firstCategory = categories.drinks[0]
                NetworkService.fetchCocktailsByCategory(category: firstCategory) { (cocktailList: CocktailList?, error: Error?) in
                    if let cocktailList = cocktailList {
                        DispatchQueue.main.async {
                            self.cocktailsDelegate.displayCategoriesAndFirstCocktailsList(categories: categories, cocktails: cocktailList)
                        }
                    } else if error != nil {
                        print("ERROR: \(error!.localizedDescription)")
                         DispatchQueue.main.async {
                            haveError = error
                        }
                    }
                }
            } else if error != nil {
                print("ERROR: \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    haveError = error
                }
            }
        }
        
        return haveError
        
    }
    func loadCocktailsByCategory(category: Category) -> Error? {
        var haveError: Error?
        NetworkService.fetchCocktailsByCategory(category: category) { (cocktailList: CocktailList?, error: Error?) in
            if let cocktailList = cocktailList {
                DispatchQueue.main.async {
                    self.cocktailsDelegate.displayCocktailsForSelectedCategory(list: cocktailList)
                }
            } else if error != nil {
                print("ERROR: \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    haveError = error
                }
            }
        }
        
        return haveError
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
