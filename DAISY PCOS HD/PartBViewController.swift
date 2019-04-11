//
//  PartBViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class PartBViewController: UIViewController, CanReceiveHADS {
    
    // var depressionScoreHADS : String?
    // var anxietyScoreHADS : String?
    @IBOutlet weak var hadsButton: UIButton!
    
    @IBOutlet weak var HADSScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToHADS" {
            
            let hadsVC = segue.destination as! HADSViewController
            
            hadsVC.delegate = self
            
        }
        
    }
    
    //MARK: - Taking HADS Test
    /***************************************************************/
    
    @IBAction func hadsPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToHADS", sender: self)
        
    }
    
    func dataReceived(depressionScore: Int, anxietyScore: Int) {
        
        hadsButton.isEnabled = false
        HADSScoreLabel.text = "Your depression score is \(depressionScore).\nYour anxiety score is \(anxietyScore)."
    }
    
    
    func updateHADS(){
        
        // HADSScoreLabel.text = "You depression score is " + depressionScoreHADS! + "\nYou anxiety score is " + anxietyScoreHADS! + "."
    
    }
    
    //MARK: - Finish PartB
    /***************************************************************/
    
    @IBAction func nextPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToFinish", sender: self)
        
    }
    
}
