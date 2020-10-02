//
//  DescriptionViewData.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

struct DetailedViewData: Decodable {
    let Country, Date: String
    let Deaths, Confirmed, Recovered, Active: Int
    
    init(detailedCountry: DetailedViewData) {
        self.Country = detailedCountry.Country
        self.Deaths = detailedCountry.Deaths
        self.Confirmed = detailedCountry.Confirmed
        self.Recovered = detailedCountry.Recovered
        self.Active = detailedCountry.Active
        self.Date = detailedCountry.Date
    }
}
