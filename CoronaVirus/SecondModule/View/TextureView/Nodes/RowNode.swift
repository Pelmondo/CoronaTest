//
//  RowNode.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 30.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import AsyncDisplayKit

class RowNode: BaseNode {
    
    //MARK: - Properties
    
    private var name: String!
    private var cases: String!
    var nameTextNode = ASTextNode()
    var casesTextNode = ASTextNode()
    
    static func createRowNode(name: String, cases: Int) -> RowNode {
        let newRowNode = RowNode()
        newRowNode.name = name
        newRowNode.cases = String(cases)
        newRowNode.configureTextNodes()
        return newRowNode
    }
    
    //MARK: - Init
    
    override init() {
        super.init()
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 16.0,
                                       justifyContent: .spaceBetween,
                                       alignItems: .start,
                                       children: [nameTextNode, casesTextNode])
        
        let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        return ASInsetLayoutSpec(insets: insets, child: hStack)
    }
    
    fileprivate func configureTextNodes() {
        let font = UIFont.boldSystemFont(ofSize: 32)
        let attributes = [NSAttributedString.Key.font: font]
        
        nameTextNode.attributedText = NSAttributedString(string: name,
                                                         attributes: attributes)
        casesTextNode.attributedText = NSAttributedString(string: cases,
                                                          attributes: attributes)
    }
    
}
