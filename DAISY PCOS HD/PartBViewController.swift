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
    
    var saveLocalResult = true
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToHADS" {
            
            let hadsVC = segue.destination as! HADSViewController
            
            hadsVC.delegate = self
            
        }
        
    }
    
    //MARK: - Store results locally
    /***************************************************************/
    
    // store the results in a local json file
    func storeLocalResults() {
        
        let patientID = QuizResult.shared().result["patientID"] as! String
        if LocalResults.localResults[patientID] != nil {
            LocalResults.localResults[patientID]?.append(ChartFactory().formatResults())
        }
        else {
            LocalResults.localResults[patientID] = [ChartFactory().formatResults()]
        }
        
        // write results to json file
        JsonFileFactory.writeJSONToFile(fileName: "UserResults", dictionary: LocalResults.localResults)
        
        print("New Data Stored in File!")
        
        // check the results
        let records: [[String: Any]] = LocalResults.localResults[patientID]!
        for record in records {
            print(record["date"]!)
            let score = record["hadsScore"] as? [String: Int]
            print(score!["depression"]!)
            print(score!["anxiety"]!)
        }
        
    }
    
    // read the stored result
    func readLocalResults() {
        
        LocalResults.localResults = JsonFileFactory.readJSONFromFile(fileName: "UserResults") as! [String : Array<[String : Any]>]
        
        print("Data History Read!")
        
    }
    
    // get Today's date
    func getCurrentDate() {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        QuizResult.shared().result["date"] = formattedDate
        
    }
    
    //MARK: - Finish PartB
    /***************************************************************/
    
    @IBAction func nextPressed(_ sender: Any) {
        
        // get the finish date
        getCurrentDate()
        
        readLocalResults()
        
        // if user finished HADS, update the local results
        if saveLocalResult && QuizResult.shared().hadsFinished == true {
            storeLocalResults()
            saveLocalResult = false
        }
        
        performSegue(withIdentifier: "goToFinish", sender: self)
        
    }
    
}
