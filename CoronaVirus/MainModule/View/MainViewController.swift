//
//  ViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 22.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Properties
    
    var viewModel: MainViewModelProtocol!
    private var mainView: MainView!

    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Choose country"
        createMainView()
        updateView()
        viewModel.startFetch()
    }
    
//    MARK: - Handlers
    
    fileprivate func createMainView() {
        mainView = MainView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        mainView.tableView.delegate = self
        mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.mainView.viewData = viewData
        }
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = tableView.cellForRow(at: indexPath)?.textLabel?.text
        let slug = mainView.countriesAPI[indexPath.row].Slug
        createNewVC(to: country, with: slug)
    }
    
    fileprivate func createNewVC(to country: String?, with slug: String) {
        let nextVC = ModuleBuilder.createSecondModule(to: slug)
        nextVC.navigationItem.title = country
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
