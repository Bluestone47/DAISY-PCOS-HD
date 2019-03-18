//
//  HADSViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 14/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit

class HADSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        // print((sender as! UIButton).tag)
        
        // Check which buttons are selected for each question
        for n in 0...questionArray.count-1 {
            
            let cell = questionTable.cellForRow(at: IndexPath(row: n, section: 0)) as! HADSTableViewCell
            
            if (cell.optionA.isSelected) { selectedAnswer.append(0) }
            else if (cell.optionB.isSelected) { selectedAnswer.append(1) }
            else if (cell.optionC.isSelected) { selectedAnswer.append(2) }
            else if (cell.optionD.isSelected) { selectedAnswer.append(3) }
            else {
                // WARNING: MUST FINISH ALL QUESTIONS BEFORE SUBMIT
            }
            
        }
        
        // Print the answer in the console
        for n in 0...questionArray.count-1 {
            print("Question\(n+1): \(selectedAnswer[n])")
        }
        
        // Return to PartB
        // performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        
    }
    
    
}
