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
    
    // MARK: - Properties
    
    private let session: URLSession
    private var task: URLSessionTask?
    
    // MARK: - Init
    
   public init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
        self.init(configuration: .default)
    }
    
    // MARK: - Load
    /// Completes with the Result<Type, Error> on the main thread.
    public func load(service: T, completion: @escaping (Result<Data, Error>) -> Void) {
        call(service.urlRequest, completion: completion)
    }
    
    /// Decodes Type. Completes with the Result<Type, Error> on the main thread.
    ///
    /// - Parameters:
    ///     - service: The *Endpoint* for the NetowrkRequest API.
    ///     - decodeType: Type that conforms to Decodable.
    ///     - completion: Completes Result<Type, Error>.
    public func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U, Error>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                } catch {
                    completion(.failure(NetworkError.dataNotDecodable))
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
    
    /// Performs a URLRequest with an async dataTask on a brackGround thread and completes on the main thread 
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data, Error>) -> Void) {
        let newTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            }
            if let response = response {
                NetworkLogger.log(response: response)
            }
            
            if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            }
        }
        task = newTask
        newTask.resume()
    }
}
