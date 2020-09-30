//
//  DescriptionViewData.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

enum DetailedViewData {
    case initial
    case loading
    case sucsess(DetailedCountryAPI)
    case failure(DetailedCountry)
    
    struct DetailedCountry {
        let name: String?
        let description: String?
    }
}

struct DetailedCountryAPI: Decodable {
    let Country: String
    let Cases: Int
    let Status: String
    
    init(detailedCountry: DetailedCountryAPI) {
        self.Country = detailedCountry.Country
        self.Cases = detailedCountry.Cases
        self.Status = detailedCountry.Status
    }
}
