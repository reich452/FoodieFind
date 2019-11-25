//
//  LunchViewController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, ActivityIndicatorPresenter {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var activityIndicator = UIActivityIndicatorView()
    var restaurants: [Restaurant] = []
    
    private lazy var collectionViewFlowLayout: CustomCollectionViewFlowLayout = {
        let layout = CustomCollectionViewFlowLayout(itemWith: view.frame.width, itemHeight: 180, lineSpace: 0, interItemSpace: 0)
        layout.display = .list
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = self.collectionViewFlowLayout
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        loadRestarunts()
    }
    
    private func loadRestarunts() {
        let restController = RestaurantController.shared
        showActivityIndicator()
        restController.getRestaurants { [weak self] result in
            switch result {
            case .success(let restaurants):
                self?.restaurants = restaurants
                self?.hideActivityIndicator()
                self?.collectionView.reloadData()
            case .failure(let error):
                self?.hideActivityIndicator()
                self?.showNoActionAlert(titleStr: "Error Loading Restaurants", messageStr: error.localizedDescription, style: .cancel)
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

extension RestaurantViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            let restaurant = restaurants[indexPath.row]
            guard let imageUrl = restaurant.backgroundImageURL else { return }
            URLSession.shared.dataTask(with: imageUrl).resume()
        }
    }
}
