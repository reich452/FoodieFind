//
//  RestaurantController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

final class RestaurantController {
    
    static let shared = RestaurantController()
    
    private init() {}
    
    private let service = Router<RestaurantEndPoint>()
    
    func getRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        
        service.load(service: .fetchRestaurants, decodeType: RestaurantsJSON.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let restaurants):
                completion(.success(restaurants.restaurants))
            }
        }
    }
}
