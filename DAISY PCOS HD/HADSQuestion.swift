//
//  HADSQuestion.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class HADSQuestion {
    
    let questionText : String
    let answer : [String]
    let whatFor : String
    
    init(text : String, answer : [String], whatFor : String) {
        self.questionText = text
        self.answer = answer
        self.whatFor = whatFor
    }
    
}
