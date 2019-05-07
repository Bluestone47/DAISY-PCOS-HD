//
//  FinishViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

class FinishViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Load the line charts
        
    }
    
    
    static func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        // Only submit HADS if the user have finished it
        if  QuizResult.shared().hadsFinished == true {
            HADSPost.hadsSubmit()
        }
        
        print(QuizResult.shared().result)
        
        resetGlobalVariables()
        // Go back to the home screen of the application
        // navigationController?.popToRootViewController(animated: true)
        performSegue(withIdentifier: "goToMain", sender: self)
        
    }
    
    func resetGlobalVariables() {
        UserInfoObject.auth = false
        QuizResult.shared().hadsFinished = false
    }
    
    
    
    
}
