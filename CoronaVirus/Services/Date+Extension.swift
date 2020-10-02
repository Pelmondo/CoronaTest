//
//  Data+Extension.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 30.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

extension Date {
    static func from(_ value: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let newDate = dateFormatter.date(from: value) {
            return newDate
        }
        else { return nil }
    }
}
