//
//  FinishViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

// Show UnderLine in label
extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

// Show UnderLine in button
extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

class FinishViewController: UIViewController {
    
    @IBOutlet weak var lineChart: LineChartView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChartFactory().loadChartEntry()
        ChartFactory().loadChartData()
        
        updateChart()
    }
    
    func updateChart() {
        
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: ChartFactory.dateArray)
        lineChart.xAxis.granularity = 1
        
        lineChart.data = ChartFactory.depressionData
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        // Only submit HADS if the user have finished it
        if  QuizResult.shared().hadsFinished == true {
            HADSPost.hadsSubmit()
        }
        
        print(QuizResult.shared().result)
        
        resetGlobalVariables()
        // Go back to the home screen of the application
        // navigationController?.popToRootViewController(animated: true)
        performSegue(withIdentifier: "goToMain", sender: self)
        
    }
    
    func resetGlobalVariables() {
        UserInfoObject.auth = false
        QuizResult.shared().hadsFinished = false
    }
    
    
    
    
}
