//
//  SystemImage.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

enum ImageHelper: String {
    
    case webBack = "ic_webBack"
    case webForward = "ic_webForward"
    case webRefresh = "ic_webRefresh"
    
    func set() -> UIImage {
        return UIImage(named: self.rawValue) ?? UIImage(systemName: "exclamationmark.circle.fill")!
    }
}
