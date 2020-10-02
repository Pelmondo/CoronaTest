//
//  RxNetworkService.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 28.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import RxSwift

protocol RxNetworkServiceProtocol {
    func fetchCountries() -> Observable<[CountryViewModel]>
    func fetchDetailedCountry(_ slug: String, to date: String) -> Observable<DetailedViewData>
}

class RxNetworkService: RxNetworkServiceProtocol {
    
    private let provider = NetworkProvider<CountryService>()
    
    func fetchCountries() -> Observable<[CountryViewModel]> {
        return Observable.create { observer -> Disposable in
            self.provider.load(service: .countries, decodeType: [CountryViewModel].self) { result in
                switch result {
                case .success(let countries):
                    observer.onNext(countries)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create { }
        }
    }
    
    func fetchDetailedCountry(_ slug: String, to date: String) -> Observable<DetailedViewData> {
        return Observable.create { observer -> Disposable in
            
            self.provider.load(service: .detailedCountry(slug: slug), decodeType: [DetailedViewData].self) { result in
                switch result {
                case .success(let detailedCountry):
                    let chooseCountry = detailedCountry.filter {$0.Date.contains("\(date)")}
                    guard let detailedCountry = chooseCountry.last else {
                        observer.onError(NSError(domain: "simple error",
                                                 code: -1,
                                                 userInfo: nil))
                        return
                    }
                    observer.onNext(detailedCountry)
                case.failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create { }
        }
    }
}
