//
//  QuizViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    let allQuestions = HADSQuestionBank()
    var pickedAnswer : Int = 0
    var questionNumber : Int = 0
    var depressionScore : Int = 0
    var anxietyScore : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToFinish", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinish" {
            
            let desitinationVC = segue.destination as! FinishViewController
            
            desitinationVC.depressionScoreHADS = String(depressionScore)
            desitinationVC.anxietyScoreHADS = String(anxietyScore)
            
        }
    }
    
    
}
