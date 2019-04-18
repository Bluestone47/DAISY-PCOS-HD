//
//  UserInfo.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 31/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class UserInfo{
    
    // create a singleton result object
    private static var sharedUserInfo: UserInfo = {
        let userInfo = UserInfo()
        return userInfo
    }()
    
    var email: String
    var id: String
    var center: String
    var patientID: String
    
    private init() {
        email = ""
        id = ""
        center = ""
        patientID = ""
    }
    
    init(email: String, id: String, center: String) {
        self.email = email
        self.id = id
        self.center = center
        self.patientID = String(format: "\(center)-%04d", Int(id)!)
    }
    
    // access the singleton object by QuizResult.shared()
    class func shared() -> UserInfo {
        return sharedUserInfo
    }
    
}
