//
//  FinishViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        // Only submit HADS if the user have finished it
        if  QuizResult.shared().hadsFinished == true {
            HADSPost.hadsSubmit()
        }
        
        resetGlobalValuables()
        // Go back to the home screen of the application
        // navigationController?.popToRootViewController(animated: true)
        performSegue(withIdentifier: "goToMain", sender: self)
        
    }
    
    func resetGlobalValuables() {
        UserInfoObject.auth = false
        QuizResult.shared().hadsFinished = false
    }
    
    
    
    
}
