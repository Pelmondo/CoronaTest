//
//  MainViewModel.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol {
    var updateViewData: ((MockViewData) -> Void)? { get set }
    func startFetch()
}

class MainViewModel: MainViewModelProtocol {
    public var updateViewData: ((MockViewData) -> Void)?
    
    init() {
        updateViewData?(.initial)
    }
    func startFetch() {
        updateViewData?(.loading(MockViewData.Country(name: "Загрузка",
                                                      infectedPeoples: nil,
                                                      healthyPeoples: nil)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.updateViewData?(.sucsess(MockViewData.Country(name: "Russia",
                                                                infectedPeoples: 1234,
                                                                healthyPeoples: 2312)))
        }
    }
}
