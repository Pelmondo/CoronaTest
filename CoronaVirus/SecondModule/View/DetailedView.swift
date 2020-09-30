//
//  DescriptionView.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class DetailedView: UIView {
    
//    MARK: - Properties
    
    lazy var informLabel = makeInformLabel()
    lazy var descriptionLabel = makeDescriptionLabel()
    lazy var datePicker = makeDatePickerView()
    
    var viewData: DetailedViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
//    MARK: - Init
    
//    MARK: - Handlers
        
//    fileprivate func update(country: DetailedViewData.DetailedCountry) {
//        informLabel.text = "Infected:"
//        descriptionLabel.text = country.description
//        datePicker.maximumDate = Date()
//    }
//
//    fileprivate func updateAPI(detailCountry: DetailedCountryAPI) {
//        informLabel.text = "Infected:"
//        if detailCountry.Cases == 0 {
//            descriptionLabel.text =  "Нет данных"
//            datePicker.isHidden = true
//        } else {
//            datePicker.isHidden = false
//            descriptionLabel.text = String(detailCountry.Cases)
//        }
//        datePicker.maximumDate = Date()
//    }
}
