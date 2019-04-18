//
//  UserLogin.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 11/4/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class UserLogin {

    func login(email: String, password: String){
        
        // URL to web service
        let URL_SAVE_TEAM = "http://\(GetIPAddress().getIPAddress())/DaisyDbService/operation/login.php?email=\(email)&password=\(password)"
        
        //created NSURL
        // let requestURL = NSURL(string: URL_SAVE_TEAM)
        let requestURL = URL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        // let request = NSMutableURLRequest(url: requestURL! as URL)
        var request = URLRequest(url: requestURL!)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            // Here is an example of return massage
            // {"status":false,"message":"Invalid email or Password!"}
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            
            //parsing the response
            do {
                // Here is an example of return massage
                // {"status":true,"message":"Successfully Login!","user_id":"1","email":"Bruce","center_id":"GBBI"}
                
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    print(parseJSON["email"] as! String)
                    print(parseJSON["user_id"] as! String)
                    print(parseJSON["center_id"] as! String)
                    // Assign user information
                    // self.setUserInfo(email: parseJSON["email"] as! String, id: parseJSON["user_id"] as! String, center: parseJSON["center_id"] as! String)
                    let demo = UserInfo(email: parseJSON["email"] as! String, id: parseJSON["user_id"] as! String, center: parseJSON["center_id"] as! String)
                    print(demo.patientID)
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
        
    }
    
    func setUserInfo(email: String, id: String, center: String) {
        UserInfo.shared().email = email
        UserInfo.shared().id = id
        UserInfo.shared().center = center
        UserInfo.shared().patientID = String(format: "\(center)-%04d", id)
    }
    
}
