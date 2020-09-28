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
}

//TODO: - in near future injection

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        return view
    }
}
