//
//  RestaurantDetailViewController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/25/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import MapKit
import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var mapView: MKMapView!
    // MARK: - Properties
    var restaurant: Restaurant
    
    // MARK: - Init
    
    /// Dependency injection: must pass in a restaurant to init this class
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension RestaurantDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}

extension RestaurantDetailViewController: UITableViewDataSource {
    
    // MARK: - DataSource
    
    enum DetailSection: Int, CaseIterable {
        case name
        case info
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailTableViewCell.cellID, for: indexPath) as? RestaurantDetailTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(restaurant: restaurant)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantInfoTableViewCell.cellID, for: indexPath) as? RestaurantInfoTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(restaurant: restaurant)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
