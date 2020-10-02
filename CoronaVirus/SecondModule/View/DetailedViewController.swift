//
//  SecondViewController.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 23.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class DetailedViewController: ASDKViewController<BaseNode>  {

//    MARK: - Properties
    lazy var datePicker = makeDatePickerView()
    var detailedNode = DetailedViewNode()
    var viewModel: DetailedViewModelProtocol!
    private let disposeBag = DisposeBag()
    private var chooseDate: PublishSubject<Date> = PublishSubject()
    private var yesterday: Date?
    
//    MARK: - Init
    
    override init() {
        super.init(node: BaseNode())
        node.addSubnode(detailedNode)
        node.backgroundColor = .white
        node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: self.detailedNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCountry()
        datePicker.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        edgesForExtendedLayout = []
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        let calendar = Calendar.current
        yesterday = calendar.date(byAdding: .day, value: -2, to: Date())
        datePicker.maximumDate = yesterday
        bindDatePicker()
    }
    
//    MARK: - RxSwift 
    
    fileprivate func fetchCountry() {
        viewModel.fetchCountryViewModel(to: yesterday!)
            .observeOn(MainScheduler.instance)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { detailedCountry in
                self.updateView(country: detailedCountry)
            }, onError: { _ in
                self.createAllert()
                self.hiddenAll(true)
            }).disposed(by: disposeBag)
    }
    
    fileprivate func bindDatePicker() {
        datePicker.rx.date.bind(to: chooseDate).disposed(by: disposeBag)
        
        chooseDate.asObserver().subscribe(onNext: { date in
            self.viewModel.fetchCountryViewModel(
                                            to: date)
                .observeOn(MainScheduler.instance)
                .subscribe {detailedCountry in
                    self.updateView(country: detailedCountry)
                }.disposed(by: self.disposeBag)
        }, onError: { error in
            self.createAllert()
            self.hiddenAll(true)
        }).disposed(by: disposeBag)
    }
    
    //    MARK: - Handlers
        
    fileprivate func updateView(country: DetailedViewData) {
        hiddenAll(false)
        let font = UIFont.boldSystemFont(ofSize: 32)
        let attributes = [NSAttributedString.Key.font: font]
        detailedNode.infectedNode.casesTextNode.attributedText = NSAttributedString(string: "\(country.Confirmed)", attributes: attributes)
        detailedNode.deathNode.casesTextNode.attributedText = NSAttributedString(string: "\(country.Deaths)", attributes: attributes)
        detailedNode.active.casesTextNode.attributedText = NSAttributedString(string: "\(country.Active)", attributes: attributes)
        detailedNode.recovered.casesTextNode.attributedText = NSAttributedString(string: "\(country.Recovered)", attributes: attributes)
    }
    
    fileprivate func createAllert() {
        let alert = UIAlertController(title: "Ooops", message: "К сожалению, данные об этой строне отсутсвуют", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func hiddenAll(_ isHidden: Bool) {
        detailedNode.isHidden = isHidden
        datePicker.isHidden = isHidden
        
    }
}
