//
//  WelcomeViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Calming-Blurred-Background")!)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Calming-Blurred-Background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
        print("\(GetIPAddress.getIPAddress())")
        
        resultForFun()
        
        let jsonData = JsonFileFactory.readJSONFromFile(fileName: "UserResults") as? [String: Any]
        let records = (jsonData!["GBBI-0001"] as? [[String: Any]])!
        for record in records {
            print(record["date"]!)
            let score = record["hadsScore"] as? [String: Int]
            print(score!["depression"]!)
            print(score!["anxiety"]!)
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func resultForFun() {
        
        let result = [
            "patientID": "GBBI-0001",
            "date": "01-01-2000",
            "hadsScore": [
                "depression": 13,
                "anxiety": 21
            ]
            ] as [String : Any]
        
        let result2 = [
            "patientID": "GBBI-0001",
            "date": "01-01-2000",
            "hadsScore": [
                "depression": 14,
                "anxiety": 20
            ]
            ] as [String : Any]
        
        var tempJson = [String : Any]()
        var tempResult: Array<[String: Any]> = [result]
        tempResult.append(result2)
        let patientID = result["patientID"] as! String
        
        tempJson[patientID] = tempResult
        
            
        JsonFileFactory.writeJSONToFile(fileName: "UserResults", dictionary: tempJson)
        
    }
}
