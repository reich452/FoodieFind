//
//  PublicAccess.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/25/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

infix operator ???: NilCoalescingPrecedence
public func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    return optional.map { String(describing: $0) } ?? defaultValue()
}
