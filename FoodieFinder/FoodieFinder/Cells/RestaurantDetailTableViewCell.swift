//
//  RestaurantDetailTableViewCell.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/25/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var catagoryLabel: UILabel!
    
    func configureCell(restaurant: Restaurant) {
        nameLabel.text = restaurant.name
        catagoryLabel.text = restaurant.category
    }
    
    static var cellID: String {
        return String(describing: self)
    }
}
