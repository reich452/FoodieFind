//
//  Place.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation
import MapKit

protocol Place {
    var mainTitle: String { get }
    var detailTitle: String { get }
    var coordinate2D: CLLocationCoordinate2D { get }
}

extension Restaurant: Place {
    var mainTitle: String {
        name
    }
    
    var detailTitle: String {
        category
    }
    
    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
    }
}
