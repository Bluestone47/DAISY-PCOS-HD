//
//  UserInfo.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 31/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class UserInfo{
    
    var email: String
    var id: String
    var center: String
    var patientID: String
    
    init() {
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
    
}
