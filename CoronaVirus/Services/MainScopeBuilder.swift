//
//  MainScopeBuilder.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 30.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import SwiftDI

class MainScopeBuilder {
    func build() -> Injector {
        let injetor = Injector()
        
        injetor.bind(RxNetworkServiceProtocol.self)
            .scope(.singleton)
            .with(RxNetworkService.init)
        
        injetor.bind(MainViewModel.self)
            .with(MainViewModel.init)
        
        injetor.bind(DetailedViewModel.self)
            .with(DetailedViewModel.init)
        
        injetor.bind(MainViewModelProtocol.self)
            .with { (provider: MainViewModel) -> MainViewModelProtocol in
                MainViewModel(rxNetworkService: injetor.resolve())
            }
            
        injetor.bind(DetailedViewModelProtocol.self)
            .with {(provider: DetailedViewModel) -> DetailedViewModelProtocol in
                DetailedViewModel(rxNetworkService: injetor.resolve())
            }
    
        return injetor
    }
}
