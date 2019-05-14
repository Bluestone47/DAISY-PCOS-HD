//
//  FinishViewController.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/3/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

// BarLineScatterCandleBubbleRenderer.swift of Charts library was edited,
// to solve the problem "circle for first value is missing" in the line chart.

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
        
        let patientID = UserInfoObject.shared().userInfo.patientID
        
        if LocalResults.localResults[patientID] != nil {
            
            ChartFactory().loadChartEntry()
            ChartFactory().loadChartData()
            
            updateChart()
            
        }
    }
    
    func updateChart() {
        
        lineChart.data = ChartFactory.lineChartData
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: ChartFactory.dateArray)
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        lineChart.xAxis.avoidFirstLastClippingEnabled = true
        
        
        lineChart.legend.font = UIFont(name: "Verdana", size: 16.0)!
        lineChart.legend.horizontalAlignment = .left
        lineChart.legend.verticalAlignment = .bottom
//        lineChart.legend.orientation = .vertical
        lineChart.legend.xEntrySpace = 20
        lineChart.legend.yEntrySpace = 0
        
//        lineChart.extraTopOffset = 40
//        lineChart.fitScreen()
        lineChart.notifyDataSetChanged()
        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        // Only submit HADS if the user have finished it
        //        if  QuizResult.shared().hadsFinished == true {
        //            HADSPost.hadsSubmit()
        //        }
        
        print(QuizResult.shared().result)
        
        resetGlobalVariables()
        resetUserDefaults()
        // Go back to the home screen of the application
        // navigationController?.popToRootViewController(animated: true)
        performSegue(withIdentifier: "goToMain", sender: self)
        
    }
    
    func resetGlobalVariables() {
        UserInfoObject.auth = false
        QuizResult.shared().hadsFinished = false
    }
    
    func resetUserDefaults() {
        let defaults = UserDefaults.standard
        let defaultsKey = "LastResult"
        let reset = ["PatientID": ""]
        defaults.set(reset, forKey: defaultsKey)
    }
    
    
}
