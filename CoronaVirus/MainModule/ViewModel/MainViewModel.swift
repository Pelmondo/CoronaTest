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
    
    var networkService: NetworkServiceProtocol!
    private var countries = [CountryAPI]()
    
    init() {
        updateViewData?(.initial)
    }
    
    func startFetch() {
        networkService.getCountryList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let countries):
                guard let countries = countries else { return }
                self.countries = countries
                self.updateUI(countries)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func updateUI(_ countries: [CountryAPI]) {
        DispatchQueue.main.async {
            self.updateViewData?(.sucsess(countries))
        }
    }
    
    fileprivate func failure(error: Error) {
        DispatchQueue.main.async {
            self.updateViewData?(.failure(error))
        }
    }
}

