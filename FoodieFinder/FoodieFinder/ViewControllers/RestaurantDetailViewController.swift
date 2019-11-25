//
//  RestaurantDetailViewController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/25/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    // MARK: - Properties
    var restaurant: Restaurant
    
    // MARK: - Init
    
    /// Dependency injection: must pass in a restaurant
    init?(coder: NSCoder, restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a restaurant.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = restaurant.name
    }
}
