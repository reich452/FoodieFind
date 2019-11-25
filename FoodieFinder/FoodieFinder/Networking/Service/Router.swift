//
//  Router.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import Foundation

// MARK: - Protocols
public protocol NetworkRouter: class {
    /// Cancels the URLSessionTask
    func cancel()
}

public class Router<T: ServiceProtocol>: NetworkRouter {
    
    private let session: URLSession
    private var task: URLSessionTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func load(service: T, completion: @escaping (Result<Data, Error>) -> Void) {
        call(service.urlRequest, completion: completion)
    }
    
    public func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U, Error>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data, Error>) -> Void) {
        let newTask = session.dataTask(with: request) { data, _, error in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            }
            
            if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            }
        }
        newTask.resume()
    }
}
