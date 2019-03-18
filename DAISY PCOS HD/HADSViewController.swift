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
    var pickedAnswer : Int = 0
    var questionNumber : Int = 0
    var depressionScore : Int = 0
    var anxietyScore : Int = 0
    
    
    @IBOutlet weak var questionTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionTable.delegate = self
        questionTable.dataSource = self
        
        questionTable.register(UINib(nibName: "HADSTableViewCell", bundle: nil), forCellReuseIdentifier: "HADSTableViewCell")
        
        // configureTableView()
        
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

    @IBAction func question1Pressed(_ sender: Any) {
        
        print((sender as! UIButton).tag)
        
    }
    
    
    
}
