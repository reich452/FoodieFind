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
        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: view.bounds.width, lineSpace: 0, interItemSpace: 0)
        return layout
    }()
    
    // MARK: - OverRide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = self.collectionViewFlowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        loadRestarunts()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.reloadCollectionViewLayout(self.view.bounds.size.width)
    }
    
    private func reloadCollectionViewLayout(_ width: CGFloat) {
        collectionView.collectionViewLayout = self.collectionViewFlowLayout
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .compact {
            self.collectionViewFlowLayout.display = .grid(columns: 2)
            return
        }
        
        collectionViewFlowLayout.containerWidth = width
        collectionViewFlowLayout.display = view.traitCollection.horizontalSizeClass == .compact && view.traitCollection.verticalSizeClass == .regular ? CollectionDisplay.list : CollectionDisplay.grid(columns: 2)
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
    
    // MARK: - Navigation
    
    func showRestaurant(_ restaurant: Restaurant) {
        let stoyboard = UIStoryboard(name: "RestaurantDetail", bundle: nil)
        let detailVC = stoyboard.instantiateViewController(identifier: "RestaurantDetailViewController") { coder in
            RestaurantDetailViewController(coder: coder, restaurant: restaurant)
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RestaurantViewController: UICollectionViewDataSource {
    
    // MARK: - Data Source
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

extension RestaurantViewController: UICollectionViewDelegate {
    
    // MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurant = restaurants[indexPath.row]
        showRestaurant(restaurant)
    }
}

extension RestaurantViewController: UICollectionViewDataSourcePrefetching {
    
    // MARK: - PreFetch
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            let restaurant = restaurants[indexPath.row]
            guard let imageUrl = restaurant.backgroundImageURL else { return }
            URLSession.shared.dataTask(with: imageUrl).resume()
        }
    }
}
