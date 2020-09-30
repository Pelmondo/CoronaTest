//
//  DescriptionView + Extension.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

extension DetailedView {
    func makeInformLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 32)
        addSubview(label)
        label.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width / 2).isActive = true
        return label
    }
    
    func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24)
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: informLabel.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        return label
    }
    
    func makeDatePickerView() -> UIDatePicker {
        let picker = UIDatePicker()
        addSubview(picker)
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return picker
    }
}
