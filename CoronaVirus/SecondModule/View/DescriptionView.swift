//
//  DescriptionView.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    
//    MARK: - Properties
    
    lazy var nameLabel = makeNameLabel()
    lazy var descriptionLabel = makeDescriptionLabel()
    
    var viewData: DescriptionViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
//    MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            print("initial")
        case .loading(let loading):
            update(country: loading)
        case .sucsess(let sucsess):
            update(country: sucsess)
        case .failure(let failure):
            update(country: failure)
        }
    }
    
//    MARK: - Handlers
    fileprivate func update(country: DescriptionViewData.DescriptionCountry) {
        nameLabel.text = country.name
        descriptionLabel.text = country.description
    }
    
}
