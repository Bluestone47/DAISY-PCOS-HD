//
//  UserInfoObject.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 18/4/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class UserInfoObject {
    
    // create a singleton user information object
    private static var sharedUserObject: UserInfoObject = {
        let userObject = UserInfoObject()
        return userObject
    }()
    
    var userInfo = UserInfo()
    
    // Check if the user login successful
    static var auth: Bool = false
    
    // access the singleton object by UserInfoObject.shared()
    class func shared() -> UserInfoObject {
        return sharedUserObject
    }
    
}
