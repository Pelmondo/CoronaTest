//
//  SecondViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

//    MARK: - Properties
    
    var viewModel: SecondViewModelProtocol!
    private var descriptionView: DescriptionView!
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        createDescriptionView()
        updateView()
        viewModel.startFetch()
    }
    
//    MARK: - Handlers
    fileprivate func createDescriptionView() {
        descriptionView = DescriptionView()
        descriptionView.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        descriptionView.center = view.center
        view.addSubview(descriptionView)
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.descriptionView.viewData = viewData
        }
    }
}
