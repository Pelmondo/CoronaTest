//
//  Service.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 02.10.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL not exist")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        return urlComponents?.url
    }
}

