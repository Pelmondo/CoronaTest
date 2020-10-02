//
//  ViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 22.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftDI

class MainViewController: UIViewController {

    //MARK: - Properties
    
    var viewModel: MainViewModelProtocol!
    var injector: Injector!
    var mainView: MainView!
    
    //MARK: - Rx
    private let disposeBag = DisposeBag()
    private var searchText: PublishSubject<[CountryViewModel]> = PublishSubject()
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Choose country"
        createMainView()
        setUpRxSearch()
        viewModel.fetchCountriesViewModel()
        
        viewModel.filterCountries.observeOn(MainScheduler.instance).bind(to: mainView.tableView.rx.items(cellIdentifier: mainView.cellID)) {
                index, viewModel, cell in
                cell.selectionStyle = .default
                cell.textLabel?.text = viewModel.viewCountry
        }.disposed(by: disposeBag)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
//    MARK: - Handlers
    
    fileprivate func createMainView() {
        mainView = MainView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    fileprivate func configureTableView() {
        mainView.tableView.rx.modelSelected(CountryViewModel.self).subscribe(onNext: { model in
            self.createNewVC(to: model.Country, with: model.Slug)
          }).disposed(by: disposeBag)
    }
}

//MARK: - Navigation

extension MainViewController {
    fileprivate func createNewVC(to country: String?, with slug: String) {
        let nextVC = ModuleBuilder.createSecondModule(to: slug, with: injector.plus())
        nextVC.navigationItem.title = country
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setUpRxSearch() {
        mainView.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
//    func createDataSourse() {
//        searchText.observeOn(MainScheduler.instance).
//    }
}
