//
//  Cocktail.swift
//  coctail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

struct Cocktail: Codable {
    var strDrink: String?
    var strDrinkThumb: String?
}
struct CocktailList: Codable {
    var drinks: [Cocktail]
}
