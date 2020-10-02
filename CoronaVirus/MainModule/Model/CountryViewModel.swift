//
//  Country.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 22.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

struct CountryViewModel: Decodable {
    let Country: String
    let Slug: String
    
    var viewCountry: String {
       return Country
    }
    
    init(country: CountryViewModel) {
        self.Country = country.Country
        self.Slug = country.Slug
    }
}
