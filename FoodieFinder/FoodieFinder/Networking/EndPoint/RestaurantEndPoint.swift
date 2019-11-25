//
//  RestaurantEndPoint.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

enum RestaurantEndPoint {
    case fetchRestaurants
    // Can add more cases for URL endPoint API calls 
}

extension RestaurantEndPoint: ServiceProtocol {
    var baseURL: URL {
        guard let url = URL(string: "https://s3.amazonaws.com") else {
            fatalError("Base url could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchRestaurants:
            return "/br-codingexams/restaurants.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchRestaurants:
            return .get
        }
    }
    
    // TODO: - URL Headers. Ex - tokens, urlBody data
    var headers: HTTPHeaders? {
        return nil
    }
    
    // TODO: - handel url parameters if URL has query items (api keys)
    var parameters: Parameters? {
        return nil
    }
}
