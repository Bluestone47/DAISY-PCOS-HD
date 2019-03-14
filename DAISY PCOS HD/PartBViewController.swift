//
//  PartBViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class PartBViewController: UIViewController {
    
    var depressionScoreHADS : String?
    var anxietyScoreHADS : String?
    
    @IBOutlet weak var HADSScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func hadsPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToHADS", sender: self)
        
    }
    
    func updateHADS(){
        
        HADSScoreLabel.text = "You depression score is " + depressionScoreHADS! + "\nYou anxiety score is " + anxietyScoreHADS! + "."
    
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToFinish", sender: self)
        
    }
    
}
