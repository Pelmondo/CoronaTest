//
//  Country.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 22.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

struct Country {
    let name: String
    let infectedPeoples: Int
    let healthyPeoples: Int
    
    init(name: String, infectedPeoples: Int, healthyPeoples: Int ) {
        self.name = name
        self.infectedPeoples = infectedPeoples
        self.healthyPeoples = healthyPeoples
    }
}

class MockCountry {
    static var countries: [Country] = [
        Country(name: "Russia", infectedPeoples: 100, healthyPeoples: 1000000),
        Country(name: "USA", infectedPeoples: 1234214, healthyPeoples: 1233),
        Country(name: "England", infectedPeoples: 1245, healthyPeoples: 2341),
        Country(name: "Ukrain", infectedPeoples: 1234, healthyPeoples: 43255),
        Country(name: "China", infectedPeoples: 1, healthyPeoples: 100000000),
        Country(name: "North Korea", infectedPeoples: 0, healthyPeoples: 25),
        Country(name: "Germany", infectedPeoples: 64645, healthyPeoples: 4566),
        Country(name: "Italy", infectedPeoples: 23141, healthyPeoples: 12341),
        Country(name: "Brazil", infectedPeoples: 2133, healthyPeoples: 4132),
        Country(name: "Kongo", infectedPeoples: 101230, healthyPeoples: 12344),
        Country(name: "Vietnam", infectedPeoples: 213, healthyPeoples: 41312),
    ]
}
