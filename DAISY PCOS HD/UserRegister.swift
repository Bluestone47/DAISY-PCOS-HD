//
//  UserRegister.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 11/4/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation

class UserRegister {

    static func signup(registerInfo: [String: String] ){
        
        // URL to web service
        let URL_SAVE_TEAM = "http://\(GetIPAddress.getIPAddress())/DaisyDbService/operation/signup.php"
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        var info = registerInfo
        info["dob"] = convertDateFormater(info["dob"]!)
        print(info)
        //creating the post parameter by concatenating the keys and values from UserInfo
        let postParameters = try? JSONSerialization.data(withJSONObject: info)
        
        //adding the parameters to request body
        request.httpBody = postParameters
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            
            //parsing the response
            do {
                // Here is an example of return massage
                // {"status":false,"message":"email already exists!"}
                // {"status":true,"message":"Successfully Signup!","user_id":"1","email":"Bruce","center_id":"GBBI"}
                
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    if parseJSON["status"] as! Bool == true {
                        // Assign user information
                        let newUser = UserInfo(email: parseJSON["email"] as! String, id: parseJSON["user_id"] as! String, center: parseJSON["center_id"] as! String)
                        
                        UserInfoObject.shared().userInfo = newUser
                        
                        UserInfoObject.auth = true
                        
                        QuizResult.shared().result["patientID"] = newUser.patientID
                    }
                    
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
    
    static func convertDateFormater(_ date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return  dateFormatter.string(from: date!)
        
    }
    
}
