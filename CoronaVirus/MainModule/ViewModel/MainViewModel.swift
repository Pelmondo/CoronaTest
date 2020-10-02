//
//  MainViewModel.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol MainViewModelProtocol {
    func fetchCountriesViewModel()
    var searchText: BehaviorRelay<String> { get }
    var filterCountries: BehaviorRelay<[CountryViewModel]> { get }
}

class MainViewModel: MainViewModelProtocol {
   
    //MARK: - Properties
    
    var searchText: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let rxNetworkService: RxNetworkServiceProtocol
    private var countries: BehaviorRelay<[CountryViewModel]> = BehaviorRelay(value: [])
    var filterCountries: BehaviorRelay<[CountryViewModel]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    private lazy var searchTextObservable: Observable<String> = searchText.asObservable()
    private lazy var countriesObservable: Observable<[CountryViewModel]> = countries.asObservable()
    private lazy var filterCountriesObservable: Observable<[CountryViewModel]> = filterCountries.asObservable()
    
    init(rxNetworkService: RxNetworkServiceProtocol) {
        self.rxNetworkService = rxNetworkService
        bindSearchText()
    }

    //MARK: - RxNetworkService
    
    func fetchCountriesViewModel() {
        rxNetworkService.fetchCountries()
            .map ({ $0.map {
                CountryViewModel(country: $0)
            }
            }).bind(to: countries)
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSearchText() {
        searchTextObservable.subscribe(onNext:{ (search) in
            self.countriesObservable.map({
                $0.filter({
                    if search.isEmpty { return true }
                    return ($0.Country.lowercased().contains(search.lowercased()))
                })
            }).bind(to: self.filterCountries)
            .disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}

