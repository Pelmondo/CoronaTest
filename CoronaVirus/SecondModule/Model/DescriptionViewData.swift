//
//  DescriptionViewData.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

enum DescriptionViewData {
    case initial
    case loading(DescriptionCountry)
    case sucsess(DescriptionCountry)
    case failure(DescriptionCountry)
    
    struct DescriptionCountry {
        let name: String?
        let description: String?
    }
}
