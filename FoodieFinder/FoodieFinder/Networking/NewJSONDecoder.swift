//
//  NewJSONDecoder.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

/// JSONDecoder & JSONEncoder
typealias NewJSONCoder = NewJSONEncoder & NewJSONDecoder

protocol NewJSONDecoder {
    func newJSONDecoder() -> JSONDecoder
}

extension NewJSONDecoder {
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}
