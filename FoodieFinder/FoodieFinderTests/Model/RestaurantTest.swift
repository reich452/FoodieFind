//
//  RestaurantTest.swift
//  FoodieFinderTests
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

@testable import FoodieFinder
import XCTest

private let mocLocation = Location(address: "5100 Belt Line Road, STE 502", crossStreet: "Dallas North Tollway", lat: 32.950_787, lng: -96.821_118, postalCode: "75254", countryCode: "US", city: "Addison", state: "TX", country: "United States", formattedAddress: [
    "5100 Belt Line Road, STE 502 (Dallas North Tollway)",
    "Addison, TX 75254",
    "United States"])
private let mocContact = Contact(phone: "9723872337", formattedPhone: "(972) 387-2337", twitter: "hopdoddy", facebook: nil, facebookUsername: nil, facebookName: nil)
private let mocRestaurant = Restaurant(name: "Hopdoddy Burger Bar", backgroundImageURL: "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/Images/hopdoddy.png", category: "Burgers", contact: mocContact, location: mocLocation)
private let mocRestaurants = RestaurantsJSON(restaurants: [mocRestaurant])

class RestaurantTest: XCTestCase, NewJSONDecoder {

    override func setUp() {
        super.setUp()
    }
    
    func testDecodableRestaurant() {
      let data = loadStubFromBundle(withName: "SampleRestaurants", extention: "json")
      do {
        let restaurant = try newJSONDecoder().decode(RestaurantsJSON.self, from: data).restaurants.first
          XCTAssertNotNil(restaurant)
          XCTAssertEqual(mocRestaurant, restaurant)
      } catch {
          print(error)
          XCTFail(error.localizedDescription)
      }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
