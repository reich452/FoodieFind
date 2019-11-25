//
//  LunchViewController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        loadRestarunts()
    }
    
    func loadRestarunts() {
        let restController = RestaurantController.shared
        restController.getRestaurants { [weak self] result in
            switch result {
            case .success(let restaurants):
                self?.restaurants = restaurants
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
        
        let restaurant = restaurants[indexPath.row]
        cell.configure(restaurant: restaurant)
        
        return cell
    }
}
