//
//  XCTestCase.swift
//  FoodieFinderTests
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStubFromBundle(withName name: String, extention: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        guard let url = bundle.url(forResource: name, withExtension: extention) else {
            fatalError("Can't find local url from: \(name) ")
        }
        var data: Data?
        do {
            let newData = try Data(contentsOf: url)
            data = newData
        } catch {
            print("Can't use data from local source \(name)")
            fatalError(error.localizedDescription)
        }
        return data ?? Data()
    }
}
