//
//  UserInfo.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 31/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class UserInfo{
    
    let email: String
    let id: Int
    let center: String
    let centerID: String
    
    init(email: String, id: Int, center: String) {
        self.email = email
        self.id = id
        self.center = center
        self.centerID = String(format: "\(center)-%04d", id)
    }
    
}
