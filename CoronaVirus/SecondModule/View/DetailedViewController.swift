//
//  SecondViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

//    MARK: - Properties
    
    var viewModel: DetailedViewModelProtocol!
    private var detailedView: DetailedView!
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createDescriptionView()
        updateView()
        configDatePicker()
        viewModel.startFetch(status: Status.confirmed, to: Date())
    }
    
//    MARK: - Handlers
    fileprivate func createDescriptionView() {
        detailedView = DetailedView()
        view.addSubview(detailedView)
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        detailedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailedView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailedView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailedView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.detailedView.viewData = viewData
        }
    }
    
    fileprivate func configDatePicker() {
        detailedView.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc func dateChanged() {
        viewModel.startFetch(status: Status.confirmed, to: detailedView.datePicker.date)
    }
}
