//
//  DetailedViewNode.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 30.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import AsyncDisplayKit

class DetailedViewNode: BaseNode {
    
    //MARK: - Properties
 
    var infectedNode = RowNode.createRowNode(name: "Total", cases: 0)
    var deathNode = RowNode.createRowNode(name: "Death", cases: 0)
    var recovered = RowNode.createRowNode(name: "Recovered", cases: 0)
    var active = RowNode.createRowNode(name: "Active", cases: 0)
    
    override init() {
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 8.0
    
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 16.0,
                                       justifyContent: .spaceBetween,
                                       alignItems: .stretch,
                                       children: [infectedNode, deathNode
                                                  , active,recovered, spacer])
        let insets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0 )
        
        return ASInsetLayoutSpec(insets: insets, child: vStack)
    }
}
