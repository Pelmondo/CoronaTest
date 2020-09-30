//
//  SecondViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailedViewController: UIViewController {

//    MARK: - Properties
    
    var viewModel: DetailedViewModelProtocol!
    private var detailedView: DetailedView!
    private let disposeBag = DisposeBag()
    private var chooseDate: PublishSubject<Date> = PublishSubject()
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createDescriptionView()
        fetchCountry()
        detailedView.datePicker.maximumDate = Date()
        bindDatePicker()
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
    
    fileprivate func updateView(country: DetailedCountryAPI) {
        detailedView.informLabel.text = "Infected:"
        detailedView.descriptionLabel.text = String(country.Cases)
    }
    
//    MARK: - RxSwift 
    
    fileprivate func fetchCountry() {
        viewModel.fetchCountryViewModel(status: Status.confirmed,
                                        to: Date())
            .observeOn(MainScheduler.instance)
            .subscribe { detailedCountry in
                self.updateView(country: detailedCountry)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func bindDatePicker() {
        detailedView.datePicker.rx.date.bind(to: chooseDate).disposed(by: disposeBag)
        
        chooseDate.asObserver().subscribe {
            self.viewModel.fetchCountryViewModel(status: Status.confirmed,
                                            to: $0)
                .observeOn(MainScheduler.instance)
                .subscribe { detailedCountry in
                    self.updateView(country: detailedCountry)
                }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}
