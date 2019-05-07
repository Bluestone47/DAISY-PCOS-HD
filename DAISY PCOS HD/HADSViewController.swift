//
//  HADSViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

// protocal for score data back to PartB
protocol CanReceiveHADS {
    func dataReceived(depressionScore : Int, anxietyScore : Int)
}

class HADSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate : CanReceiveHADS?
    
    let questionArray = HADSQuestionBank().list
    var selectedAnswer = [Int]()
    var depressionScore : Int = 0
    var anxietyScore : Int = 0
    
    
    @IBOutlet weak var questionTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTable.delegate = self
        questionTable.dataSource = self
        
        questionTable.register(UINib(nibName: "HADSTableViewCell", bundle: nil), forCellReuseIdentifier: "HADSTableViewCell")
        
        // configureTableView()
        if (questionTable.contentSize.height < questionTable.frame.size.height) {
            questionTable.isScrollEnabled = false
        } else {
            questionTable.isScrollEnabled = true
        }
        questionTable.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HADSTableViewCell", for: indexPath) as! HADSTableViewCell
        
        cell.questionLabel.text = questionArray[indexPath.row].questionText
        cell.optionA.setTitle(questionArray[indexPath.row].answer[0], for: .normal)
        cell.optionB.setTitle(questionArray[indexPath.row].answer[1], for: .normal)
        cell.optionC.setTitle(questionArray[indexPath.row].answer[2], for: .normal)
        cell.optionD.setTitle(questionArray[indexPath.row].answer[3], for: .normal)
        
        return cell
        
    }
    
    func configureTableView() {
        questionTable.rowHeight = UITableView.automaticDimension
        questionTable.estimatedRowHeight = 280.0
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        
        var isCompleted : Bool = true
        
        // Check which buttons are selected for each question
        for n in 0...questionArray.count-1 {
            
            let cell = questionTable.cellForRow(at: IndexPath(row: n, section: 0)) as! HADSTableViewCell
            
            if (cell.optionA.isSelected) { selectedAnswer.append(0) }
            else if (cell.optionB.isSelected) { selectedAnswer.append(1) }
            else if (cell.optionC.isSelected) { selectedAnswer.append(2) }
            else if (cell.optionD.isSelected) { selectedAnswer.append(3) }
            else {
                isCompleted = false
                showAlert(title: "Incomplete", message: "Please complete all questions before proceed.")
            }
            
        }
        
        if (isCompleted) {
            
            
            // Calculate the score
            calculateScore()
            
            // save the result in dictionary
            saveResult()
            QuizResult.shared().hadsFinished = true
            
            // Send score back to PartB View
            delegate?.dataReceived(depressionScore: depressionScore, anxietyScore: anxietyScore)
            // self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            // WARNING: MUST FINISH ALL QUESTIONS BEFORE SUBMIT
        }
        
        
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func calculateScore() {
        
        for n in 0...questionArray.count-1 {
            if questionArray[n].whatFor == "D" {
                depressionScore += (3-selectedAnswer[n])
            }
            else if questionArray[n].whatFor == "A" {
                anxietyScore += (3-selectedAnswer[n])
            }
        }
        
    }
    
    func saveResult(){
        var hadsResult = [String: String]()
        hadsResult["ensat_id"] = UserInfoObject.shared().userInfo.id
        hadsResult["center_id"] = UserInfoObject.shared().userInfo.center
        for n in 0...questionArray.count-1 {
            hadsResult["qhads_\(n+1)"] = questionArray[n].answer[selectedAnswer[n]].replacingOccurrences(of:"\\", with: "")
        }
        QuizResult.shared().result["hads"] = hadsResult
        QuizResult.shared().result["hadsScore"] = ["anxiety": depressionScore, "depression": anxietyScore]
        print(QuizResult.shared().result)
    }
    
    
}
