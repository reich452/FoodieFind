//
//  MapRegionGenerator.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/25/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import MapKit

/// Protocol. Sets the region of the map using Lat & Lon
  ///
  /// - Requirements:
  ///     - CLLocationCoordinate2D: lat & lgn of a location.
  ///     - MKMapView: storyboard outlet or initalize a new one.
  ///     - call setUpRegion first before adding an annotation
protocol MapRegionGenerator: class {
    var locationCoordinate: CLLocationCoordinate2D? { get set }
    var mapKitView: MKMapView { get }
    
    /// Inits a CLLocationCoordinage2D and sets the locationCoordinate property
    func setUpRegion(lat: Double, lng: Double)
    /// Inits an annotation and adds it to a MKMapView
    func addAnnotation(with title: String, subtitle: String)
    
    /// Inits an array of MKPointAnnotation and adds it to a MKMapView
    func addAnnotations(from restaurants: [Restaurant])
    
    /// TODO: - Incomplete 
    func removeAnnotation()
    
}

extension MapRegionGenerator where Self: UIViewController {
    
    func setUpRegion(lat: Double, lng: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        locationCoordinate = location
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapKitView.setRegion(region, animated: true)
    }
    
    func addAnnotation(with title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        guard let coordinate = locationCoordinate else { return }
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapKitView.addAnnotation(annotation)
    }
    
    func addAnnotations(from restaurants: [Restaurant]) {
        if restaurants.isEmpty { return }
        var pointAnnotations = [MKPointAnnotation]()
        
        for restaurant in restaurants {
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = restaurant.coordinate2D
            pointAnnotation.title = restaurant.name
            pointAnnotation.subtitle = restaurant.category
            pointAnnotations.append(pointAnnotation)
        }
        mapKitView.addAnnotations(pointAnnotations)
    }
    
    func removeAnnotation() {
        // TODO - add remove logic
    }
}
