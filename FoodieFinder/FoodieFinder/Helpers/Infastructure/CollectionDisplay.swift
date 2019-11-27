//
//  CollectionDisplay.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation
enum CollectionDisplay {
    /// Horizontal Layout
    case inline
    /// One item per row
    case list
    /// More than one item per row
    case grid(columns: Int)
}

extension CollectionDisplay: Equatable {
    
    public static func == (lhs: CollectionDisplay, rhs: CollectionDisplay) -> Bool {
        
        switch (lhs, rhs) {
        case (.inline, .inline),
             (.list, .list):
            return true
            
        case (.grid(let lColumn), .grid(let rColumn)):
            return lColumn == rColumn
            
        default:
            return false
        }
    }
}
