//
//  Restaurant.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

struct RestaurantsJSON: Codable {
    let restaurants: [Restaurant]
}

struct Restaurant: Codable, Equatable {
    
    let name: String
    let backgroundImageURL: URL?
    let category: String
    let contact: Contact?
    let location: Location
}

struct Contact: Codable, Equatable {
    
    let phone: String
    let formattedPhone: String
    let twitter: String?
    let facebook: String?
    let facebookUsername: String?
    let facebookName: String?
    
    var twitterFormat: String {
        "@\(twitter ??? "")"
    }
    
    var facebookFormat: String {
        "Facebook \(facebookName ??? "")"
    }
}

struct Location: Codable, Equatable {
    
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let countryCode: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
    
    var addressInfo: String {
        formattedAddress.joined(separator: ", ")
    }
    
    private enum CodingKeys: String, CodingKey {
        case address
        case crossStreet
        case lat
        case lng
        case postalCode
        case countryCode = "cc"
        case city
        case state
        case country
        case formattedAddress
    }
}
