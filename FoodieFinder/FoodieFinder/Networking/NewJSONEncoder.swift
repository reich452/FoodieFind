//
//  NewJSONEncoder.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

protocol NewJSONEncoder {
    func newJSONEncoder() -> JSONEncoder
}

extension NewJSONEncoder {
    
    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        return encoder
    }
}
