//
//  MainView.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class MainView: UIView {
    
//  MARK: - Proprties
    
    lazy var tableView = makeTableView()
    lazy var activityIndicator = makeActivityIndicator()
    
    var viewData: MockViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    //TODO: - Clean this
    var countryName = "Empty"
    let cellID = "cellID"
    var countriesAPI = [CountryAPI]()
    
//  MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            activityIndicator.startAnimating()
        case .loading(let loading):
            print(loading.Country)
        case .sucsess(let sucsess):
            updateAPI(countries: sucsess, isHidden: false)
            activityIndicator.stopAnimating()
        case .failure(let erorr):
            print(erorr.localizedDescription)
            activityIndicator.stopAnimating()
        }
    }
    
//  MARK: - Handlers
    
    fileprivate func updateAPI(countries: [CountryAPI], isHidden: Bool) {
        self.countriesAPI = countries
        tableView.isHidden = isHidden
        tableView.reloadData()
        activityIndicator.isHidden = !isHidden
    }
}

//MARK: UITableViewDataSource

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = countriesAPI[indexPath.row].Country
        return cell
    }
}
