//
//  SecondViewModel.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol SecondViewModelProtocol {
    var updateViewData: ((DescriptionViewData) -> Void)? { get set }
    func startFetch()
}

class SecondViewModel: SecondViewModelProtocol {
    var updateViewData: ((DescriptionViewData) -> Void)?
    var someData: DescriptionViewData.DescriptionCountry!
    
    init() {
        updateViewData?(.initial)
    }
    
    func startFetch() {
        updateViewData?(.loading(DescriptionViewData.DescriptionCountry(name: "Loading",
                                                                        description: nil)))

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.updateViewData?(.sucsess((self?.someData)!))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.updateViewData?(.failure(DescriptionViewData.DescriptionCountry(name: "Error!",
                                                                                  description: nil)))
        }
    }
}
