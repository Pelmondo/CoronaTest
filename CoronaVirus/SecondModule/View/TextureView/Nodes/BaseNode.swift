//
//  BaseNode.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 30.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import AsyncDisplayKit

class BaseNode: ASDisplayNode {
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
    }
}
