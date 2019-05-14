//
//  WelcomeViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

// Extension for set hex color
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonBorderColor = UIColor(rgb: 0xDCF8E5).cgColor
        
        loginButton.backgroundColor = .clear
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = buttonBorderColor
//        loginButton.layer.borderColor = UIColor.black.cgColor
        
        registerButton.backgroundColor = .clear
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = buttonBorderColor
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Calming-Blurred-Background")!)
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "Calming-Blurred-Background")
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
        print("\(GetIPAddress.getIPAddress())")
        
//        resultForTest()
        
        LocalResults.localResults = JsonFileFactory.readJSONFromFile(fileName: "UserResults") as! [String : Array<[String : Any]>]
        print(LocalResults.localResults)
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func resultForTest() {
        
        let result = [
            "date": "09-05-2019",
            "hadsScore": [
                "depression": 13,
                "anxiety": 21
            ]
            ] as [String : Any]
        
        let result2 = [
            "date": "10-04-2019",
            "hadsScore": [
                "depression": 14,
                "anxiety": 20
            ]
            ] as [String : Any]
        
        var tempJson = [String : Any]()
        var tempResult: Array<[String: Any]> = [result]
        tempResult.append(result2)
        let patientID = QuizResult.shared().result["patientID"] as! String
        
        tempJson[patientID] = tempResult
        
            
        JsonFileFactory.writeJSONToFile(fileName: "UserResults", dictionary: tempJson)
        
    }
}
