//
//  Category.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

struct Category: Codable {
    var strCategory: String?
}

struct CategoriesList: Codable {
    var drinks: [Category]
}
