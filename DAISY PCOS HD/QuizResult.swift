//
//  QuizResult.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 31/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class QuizResult{
    
    // create a singleton result object
    private static var sharedRestult: QuizResult = {
        let quizResult = QuizResult()
        return quizResult
    }()
    
    // var result = Dictionary<String, Any>()
    var result = [String: Any]()
    
    // HADS is an optional questionaire
    var hadsFinished = false
    
    private init() {
        result = [
            "id": "",
            "hads": [
                "ensat_id": "",
                "center_id": "",
                "qhads_1": "",
                "qhads_2": "",
                "qhads_3": "",
                "qhads_4": "",
                "qhads_5": "",
                "qhads_6": "",
                "qhads_7": "",
                "qhads_8": "",
                "qhads_9": "",
                "qhads_10": "",
                "qhads_11": "",
                "qhads_12": "",
                "qhads_13": "",
                "qhads_14": ""
            ]
        ]
        hadsFinished = false
    }
    
    // access the singleton object by QuizResult.shared()
    class func shared() -> QuizResult {
        return sharedRestult
    }
    
}
