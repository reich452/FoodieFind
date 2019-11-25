//
//  ServiceProtocol.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}

extension ServiceProtocol {
    /// Builds the urlRequest.
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }

    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL.absoluteString)
        urlComponents?.path = path

        if httpMethod == .get {
            // add query items to url
            guard let parameters = parameters as? [String: String] else {
                return urlComponents?.url
            }
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        // TODO: - Handel all HTTP methods 

        return urlComponents?.url
    }
}
