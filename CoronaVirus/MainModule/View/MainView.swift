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
    var countryName = "Empty"
    let cellID = "cellID"
//  MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            update(country: nil, isHidden: true)
            activityIndicator.startAnimating()
        case .loading(let loading):
            update(country: loading, isHidden: false)
            activityIndicator.startAnimating()
        case .sucsess(let sucsess):
            update(country: sucsess, isHidden: false)
            activityIndicator.stopAnimating()
        case .failure(let failure):
            update(country: failure, isHidden: false)
            activityIndicator.stopAnimating()
        }
    }
    
//  MARK: - Handlers
    
    fileprivate func update(country: MockViewData.Country?, isHidden: Bool) {
        countryName = country?.name ?? "empty"
        tableView.isHidden = isHidden
        tableView.reloadData()
        activityIndicator.isHidden = !isHidden
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = countryName
        return cell
    }
}
