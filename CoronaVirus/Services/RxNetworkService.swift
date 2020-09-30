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
    func fetchDetailedCountry(_ slug: String, status: Status,
                              to date: String) -> Observable<DetailedCountryAPI>
}

class RxNetworkService: RxNetworkServiceProtocol {
    
    func fetchCountries() -> Observable<[CountryViewModel]> {
        return Observable.create { observer -> Disposable in
            let urlString = "https://api.covid19api.com/countries"
            guard let url = URL(string: urlString) else {
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: url) {data, _, _ in
                guard let data = data else {
                    observer.onError(NSError(domain: "simple error", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let countries = try JSONDecoder().decode([CountryViewModel].self, from: data)
                    observer.onNext(countries)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchDetailedCountry(_ slug: String, status: Status,
                              to date: String) -> Observable<DetailedCountryAPI> {
        return Observable.create { observer -> Disposable in
            let urlString = "https://api.covid19api.com/country/\(slug)/status/\(status)?from=2020-03-01T00:00:00Z&to=\(date)T00:00:00Z"
            guard let url = URL(string: urlString) else {
                return Disposables.create { }
            }
            
            let task = URLSession.shared.dataTask(with: url) {data, _, _ in
                guard let data = data else {
                    observer.onError(NSError(domain: "simple error", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let country = try JSONDecoder().decode([DetailedCountryAPI].self, from: data)
                    guard let detailedCountry = country.last else {
                        observer.onError(NSError(domain: "simple error", code: -1, userInfo: nil))
                        return
                    }
                    observer.onNext(detailedCountry)
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
