//
//  NetworkError.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case authentication
    case badRequest
    case dataNotDecodable
    case encodingFailure(Error)
    case failed
    case forwarded(Error)
    case forwardedString(errorString: String)
    case jsonConversionFailure
    case imageDataFailure
    case internalServerError
    case incorrectParameters
    case invalidUrl
    case noConnection
    case noDataReturned
    case outdated
    case unauthorized
    case unknown
}
