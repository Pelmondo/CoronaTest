//
//  SecondViewModel.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol DetailedViewModelProtocol {
    var updateViewData: ((DetailedViewData) -> Void)? { get set }
    func startFetch(status: Status, to date: Date)
}

class DetailedViewModel: DetailedViewModelProtocol {
    public var updateViewData: ((DetailedViewData) -> Void)?
    
    var slug: String = ""
    var networkService: NetworkServiceProtocol!
    
    init() {
        updateViewData?(.initial)
    }
    
    func startFetch(status: Status, to date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        networkService.getNumberOfCases(slug, status: status, to: formatter.string(from: date)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let detailCountry):
                guard let detailCountry = detailCountry else { return }
                self.updateUI(detailCountry: detailCountry)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func updateUI(detailCountry: DetailedCountryAPI) {
        DispatchQueue.main.async {
            self.updateViewData?(.sucsess(detailCountry))
        }
    }
}
