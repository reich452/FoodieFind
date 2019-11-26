//
//  MapViewController.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MapRegionGenerator {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Properties
    private let identifier = "annotationID"
    var restaurants = [Restaurant]()
    var locationCoordinate: CLLocationCoordinate2D?
    var mapKitView = MKMapView()
    
    /// Dependency injection: must pass in restaurants to init this class
    init?(coder: NSCoder, restaurants: [Restaurant]) {
        self.restaurants = restaurants
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a restaurant.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        mapKitView = mapView
        guard let firstRestaurant = restaurants.first else { return }
        setUpRegion(lat: firstRestaurant.location.lat, lng: firstRestaurant.location.lng)
        addAnnotations(from: restaurants)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
