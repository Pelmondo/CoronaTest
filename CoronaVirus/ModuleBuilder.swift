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
    static func createMainModule(injector: Injector) -> UIViewController
    static func createSecondModule(to slug: String, with injector: Injector) -> UIViewController
}

//TODO: - in near future injection

class ModuleBuilder: Builder {
    static func createMainModule(injector: Injector) -> UIViewController {
        let view = MainViewController()
        view.injector = injector
        view.viewModel = view.injector.resolve()
        return view
    }
    
    static func createSecondModule(to slug: String, with injector: Injector) -> UIViewController {
        let injector = injector
        let view = DetailedViewController()
        view.viewModel = injector.resolve()
        view.viewModel.slug = slug
        return view
    }
}
