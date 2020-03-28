//
//  CategoryTableViewCell.swift
//  cocktail-categoies-app
//
//  Created by Serhiy Prikhodko on 3/26/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!

    // MARK: - Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with category: Category?) {
        if let category = category {
            self.nameLabel.text = category.strCategory
        }
    }

}
