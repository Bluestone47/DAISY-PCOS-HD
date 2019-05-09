//
//  PartBViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class PartBViewController: UIViewController, CanReceiveHADS {
    
    @IBOutlet weak var partBLabel: UILabel!
    
    @IBOutlet weak var berlinLabel: UILabel!
    @IBOutlet weak var hadsLabel: UILabel!
    @IBOutlet weak var essLabel: UILabel!
    
    @IBOutlet weak var hadsButton: UIButton!
    @IBOutlet weak var HADSScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadLabels()
        
    }
    
    func loadLabels() {
        
        partBLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        berlinLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        hadsLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        essLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
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
    
    // Receive results from HADS and show score in label
    func dataReceived(depressionScore: Int, anxietyScore: Int) {
        
        hadsButton.isEnabled = false
        HADSScoreLabel.text = "Your depression score is \(depressionScore).\nYour anxiety score is \(anxietyScore)."
    }
    
    //MARK: - Finish PartB
    /***************************************************************/
    
    @IBAction func nextPressed(_ sender: Any) {
        
        getCurrentDate()
        storeResultsLocally()
        
        performSegue(withIdentifier: "goToFinish", sender: self)
        
    }
    
    // store the results in a local json file
    func storeResultsLocally() {
        
    }
    
    // get Today's date
    func getCurrentDate() {
        
        let date = Date()
        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
//        let calendar = Calendar.current
//        calendar.component(.year, from: date)
//        calendar.component(.month, from: date)
//        calendar.component(.day, from: date)
        
        QuizResult.shared().result["date"] = formattedDate
        
    }
    
}
