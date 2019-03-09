//
//  FinishViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    var depressionScoreHADS : String?
    var anxietyScoreHADS : String?
    
    @IBOutlet weak var depressionScoreLabel: UILabel!
    @IBOutlet weak var anxietyScoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        depressionScoreLabel.text = "You depression score is " + depressionScoreHADS! + "."
        anxietyScoreLabel.text = "You anxiety score is " + anxietyScoreHADS! + "."
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    

}
