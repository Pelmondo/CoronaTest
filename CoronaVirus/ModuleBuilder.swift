//
//  ModuleBuilder.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit
import SwiftDI

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createSecondModule(to slug: String) -> UIViewController
}

//TODO: - in near future injection

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let viewModel = MainViewModel()
        let view = MainViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func createSecondModule(to slug: String) -> UIViewController {
        let viewModel = DetailedViewModel()
        let view = DetailedViewController()
        let networkService = NetworkService.shared
        viewModel.networkService = networkService
        viewModel.slug = slug
        view.viewModel = viewModel
        return view
    }
}
