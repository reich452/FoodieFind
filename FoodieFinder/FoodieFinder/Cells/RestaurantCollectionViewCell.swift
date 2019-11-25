//
//  RestaurantCollectionViewCell.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    func configure(restaurant: Restaurant) {
        nameLabel.text = restaurant.name
        typeLabel.text = restaurant.category
        guard let imageURL = restaurant.backgroundImageURL else {
            itemImageView.image = #imageLiteral(resourceName: "cellGradientBackground")
            return
        }
        itemImageView.setImage(from: imageURL, withPlaceholder: #imageLiteral(resourceName: "cellGradientBackground"))
    }
}
