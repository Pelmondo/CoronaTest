//
//  MainView + Extension.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

extension MainView {
    func makeTableView() -> UITableView {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.estimatedRowHeight = 42
        table.rowHeight = UITableView.automaticDimension
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        table.delegate = self
        table.dataSource = self
        addSubview(table)
        table.topAnchor.constraint(equalTo: topAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return table
    }
    
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        return indicator
    }
}
