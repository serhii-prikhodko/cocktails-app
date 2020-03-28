//
//  DrinksPresenter.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

protocol PresenterView: class {
    func loadDrinks()
}

class DrinksPresenter {
    weak var view: PresenterView?
    
    init(with view: PresenterView) {
        self.view = view
    }
}
