//
//  CountryService.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 02.10.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

enum CountryService {
    case countries
    case detailedCountry(slug: String)
}

extension CountryService: Service {
    var baseURL: String {
        return "https://api.covid19api.com"
    }
    
    var path: String {
        switch self {
        case .countries:
            return "/countries"
        case.detailedCountry(let slug):
            return "/total/country/\(slug)"
        }
    }
    
    var method: ServiceMethod {
        return .get
    }
}
