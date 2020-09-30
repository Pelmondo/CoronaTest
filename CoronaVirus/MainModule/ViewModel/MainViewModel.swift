//
//  MainViewModel.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import RxSwift

protocol MainViewModelProtocol {
    func fetchCountriesViewModel() -> Observable<[CountryViewModel]>
}

class MainViewModel: MainViewModelProtocol {
   
    private let rxNetworkService: RxNetworkServiceProtocol
    
    init(rxNetworkService: RxNetworkServiceProtocol = RxNetworkService()) {
        self.rxNetworkService = rxNetworkService
    }

    //MARK: - RxNetworkService
    
    func fetchCountriesViewModel() -> Observable<[CountryViewModel]> {
        rxNetworkService.fetchCountries().map { $0.map {
            CountryViewModel(country: $0)}
        }
    }
}

