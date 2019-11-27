//
//  UIView+Extention.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/26/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

extension UIView: ViewExtensionProtocol {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                paddingTop: CGFloat,
                bottom: NSLayoutYAxisAnchor?,
                paddingBottom: CGFloat,
                left: NSLayoutXAxisAnchor?,
                paddingLeft: CGFloat,
                right: NSLayoutXAxisAnchor?,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true }
        
        if let right = right { rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true }
        
        if let left = left { leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true }
        
        if width != 0 { widthAnchor.constraint(equalToConstant: width).isActive = true }
        
        if height != 0 { heightAnchor.constraint(equalToConstant: height).isActive = true }
    }
    
    func anchorWith(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, greaterHeight: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true }
        
        if let right = right { rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true }
        
        if let left = left { leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true }
        
        if width != 0 { widthAnchor.constraint(equalToConstant: width).isActive = true }
        
        if greaterHeight != 0 { heightAnchor.constraint(greaterThanOrEqualToConstant: greaterHeight).isActive = true }
    }
}
