//
//  DetailedViewController+Extension.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 30.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

extension DetailedViewController {
    func makeDatePickerView() -> UIDatePicker {
        let picker = UIDatePicker()
        view.addSubview(picker)
        picker.datePickerMode = .date
        picker.minimumDate = Date.from("02.03.2020")
        picker.preferredDatePickerStyle = .wheels
        picker.sizeToFit()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return picker
    }
}
