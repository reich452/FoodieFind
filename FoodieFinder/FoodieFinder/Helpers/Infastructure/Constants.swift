//
//  Constants.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

enum Constants: String {
    /// Storyboard ID
    case mapSB = "Map"
    /// ViewController class name
    case mapVC = "MapViewController"
    case restaurantCellID = "restaurantCell"
    /// Storyboard ID
    case restaurantDetailSB = "RestaurantDetail"
    /// ViewController class name 
    case restaurantDetailVC = "RestaurantDetailViewController"
    
    var string: String {
        return String(describing: self.rawValue)
    }
}
