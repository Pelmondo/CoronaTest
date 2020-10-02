//
//  NetworkProvider.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 02.10.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

class NetworkProvider<T: Service> {
    var urlSession = URLSession.shared
    
    init() {}
    
    func load(service: T, completion: @escaping(Result<Data, Error>) -> Void) {
        call(service.urlRequest, completion: completion)
    }
    
    func load<U>(service: T, decodeType: U.Type,
                 completion: @escaping(Result<U, Error>) -> Void ) where U: Decodable {
        call(service.urlRequest) { result in
                   switch result {
                   case .success(let data):
                       let decoder = JSONDecoder()
                       do {
                           let resp = try decoder.decode(decodeType, from: data)
                           completion(.success(resp))
                       }
                       catch {
                           completion(.failure(error))
                       }
                   case .failure(let error):
                       completion(.failure(error))
                   }
        }
    }
}

extension NetworkProvider {
    private func call(_ request: URLRequest,
                      deliverQueue: DispatchQueue = DispatchQueue.main,
                      completion: @escaping(Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            } else {
                deliverQueue.async {
                    completion(.failure(NSError(domain: "EMPTY",
                                                code: -1,
                                                userInfo: nil)))
                }
            }
        }.resume()
    }
}
