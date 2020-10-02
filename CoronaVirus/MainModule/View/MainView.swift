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
    lazy var searchBar = makeSearchBar()

    let cellID = "cellID"
    
}
