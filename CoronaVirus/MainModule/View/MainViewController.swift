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

class MainViewController: UIViewController {

    //MARK: - Properties
    
    var viewModel: MainViewModelProtocol!
    private var mainView: MainView!
    
    //MARK: - Rx
    private let disposeBag = DisposeBag()

    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Choose country"
        createMainView()
        viewModel.fetchCountriesViewModel().observeOn(MainScheduler.instance).bind(to: mainView.tableView.rx.items(cellIdentifier: mainView.cellID)) { index, viewModel, cell in
            cell.textLabel?.text = viewModel.viewCountry
        }.disposed(by: disposeBag)
        
        configureTableView()
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
        let nextVC = ModuleBuilder.createSecondModule(to: slug)
        nextVC.navigationItem.title = country
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
