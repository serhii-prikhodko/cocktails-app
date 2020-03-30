//
//  SingleDrinkTableViewCell.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/25/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class SingleDrinkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailUIImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(with cocktail: Cocktail?) {
        self.cocktailUIImageView.image = UIImage(named: "no_image_placeholder")
        if let cocktail = cocktail {
            self.cocktailNameLabel.text = cocktail.strDrink
            NetworkService.fetchCocktailImage(cocktail: cocktail, completionHandler: {(data: Data?) in
                if let data = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.cocktailUIImageView.image = UIImage(data: data)
                    }
                }
            })
        }
    }

}
