//
//  ViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 22.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.estimatedRowHeight = 42
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    private let cellID = "cell"
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
    }
    
//    MARK: - Handlers

    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

//MARK: - UITableViewDataSource UITableViewDelegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "first"
        return cell
    }
}
