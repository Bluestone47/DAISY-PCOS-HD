//
//  HADSPost.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 31/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

//
// Note: MySQL8.0 doesn't support [caching_sha2_password]

import Foundation

class HADSPost {
    
    static func hadsSubmit(){
        
        // URL to web service
        let URL_SAVE_TEAM = "http://\(GetIPAddress.getIPAddress())/DaisyDbService/operation/hadsPost.php"
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from results
        let hadsResult = QuizResult.shared().result["hads"]
        
        //creating the post parameter by concatenating the keys and values from QuizResult
        let postParameters = try? JSONSerialization.data(withJSONObject: hadsResult!)
        print(postParameters!)
        
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
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
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
    
}
