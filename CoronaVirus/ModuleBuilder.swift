//
//  ModuleBuilder.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createSecondModule(to country: DescriptionViewData.DescriptionCountry) -> UIViewController
}

//TODO: - in near future injection

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let viewModel = MainViewModel()
        let view = MainViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func createSecondModule(to country: DescriptionViewData.DescriptionCountry) -> UIViewController {
        let viewModel = SecondViewModel()
        let view = SecondViewController()
        viewModel.someData = country
        view.viewModel = viewModel
        return view
    }
}
