//
//  SecondViewModel.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailedViewModelProtocol {
    func fetchCountryViewModel(to date: Date) -> Observable<DetailedViewData>
    var slug: String { get set }
}

class DetailedViewModel: DetailedViewModelProtocol {

    var slug: String = ""
    
    init(rxNetworkService: RxNetworkServiceProtocol) {
        self.rxNetworkService = rxNetworkService
    }
    
    //MARK: - Rx
    private let rxNetworkService: RxNetworkServiceProtocol
    
    func fetchCountryViewModel(to date: Date) -> Observable<DetailedViewData> {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        return rxNetworkService.fetchDetailedCountry(slug, to: formatter.string(from: date))
            .map { detailedCountry in
                return DetailedViewData(detailedCountry: detailedCountry)
        }
    }
}
