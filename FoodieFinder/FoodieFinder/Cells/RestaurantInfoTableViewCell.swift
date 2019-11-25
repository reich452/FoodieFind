//
//  RestaurantInfoCollectionViewCell.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/25/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class RestaurantInfoTableViewCell: UITableViewCell {
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var twitterLabel: UILabel!
    @IBOutlet private weak var facebookLabel: UILabel!
    
    func configureCell(restaurant: Restaurant) {
        addressLabel.text = restaurant.location.addressInfo
        if let contact = restaurant.contact {
            phoneLabel.text = contact.formattedPhone
            twitterLabel.text = contact.twitterFormat
            facebookLabel.text = contact.facebookFormat
        }
    }
    
    static var cellID: String {
        return String(describing: self)
    }
}
