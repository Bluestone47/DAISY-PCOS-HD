//
//  ChartFactory.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 9/5/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation
import Charts

class ChartFactory {
    
    let thisResult = QuizResult.shared().result as [String: Any]
    let patientID = UserInfoObject.shared().userInfo.patientID
    
    static var dateArray = [String]()
    
    static var depressionScoreEntry = [ChartDataEntry]()
    static var anxietyScoreEntry = [ChartDataEntry]()
    
    static var depressionDataSet = LineChartDataSet()
    static var anxietyDataSet = LineChartDataSet()
    
    static var lineChartData = LineChartData()
    
    func loadChartData() {
        
        // parameters for gradient
        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        // set depressionDataSet
        ChartFactory.depressionDataSet = LineChartDataSet(entries: ChartFactory.depressionScoreEntry, label: "Depression")
        ChartFactory.depressionDataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)!
        ChartFactory.depressionDataSet.axisDependency = .left // Line will correlate with left axis values
        ChartFactory.depressionDataSet.setColor(UIColor.orange.withAlphaComponent(0.5))
        ChartFactory.depressionDataSet.setCircleColor(UIColor.orange)
        ChartFactory.depressionDataSet.lineWidth = 2.0
        ChartFactory.depressionDataSet.circleRadius = 6.0
        ChartFactory.depressionDataSet.fillAlpha = 65 / 255.0
        ChartFactory.depressionDataSet.fillColor = UIColor.green
        ChartFactory.depressionDataSet.highlightColor = UIColor.white
        ChartFactory.depressionDataSet.mode = .cubicBezier
        // set the gradient
        ChartFactory.depressionDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        ChartFactory.depressionDataSet.drawFilledEnabled = true // Draw the Gradient
        
        // set anxietyDataSet
        ChartFactory.anxietyDataSet = LineChartDataSet(entries: ChartFactory.anxietyScoreEntry, label: "Anxiety")
        ChartFactory.anxietyDataSet.valueFont = UIFont(name: "HelveticaNeue-Light", size: 16.0)!
        ChartFactory.anxietyDataSet.axisDependency = .left // Line will correlate with left axis values
        ChartFactory.anxietyDataSet.setColor(UIColor.blue.withAlphaComponent(0.5))
        ChartFactory.anxietyDataSet.setCircleColor(UIColor.blue)
        ChartFactory.anxietyDataSet.lineWidth = 2.0
        ChartFactory.anxietyDataSet.circleRadius = 6.0
        ChartFactory.anxietyDataSet.fillAlpha = 65 / 255.0
        ChartFactory.anxietyDataSet.fillColor = UIColor.blue
        ChartFactory.anxietyDataSet.highlightColor = UIColor.white
        ChartFactory.anxietyDataSet.mode = .cubicBezier
        // set the gradient
        ChartFactory.anxietyDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        ChartFactory.anxietyDataSet.drawFilledEnabled = true // Draw the Gradient
        
        ChartFactory.lineChartData.addDataSet(ChartFactory.depressionDataSet)
        ChartFactory.lineChartData.addDataSet(ChartFactory.anxietyDataSet)
        
        // convert dataset to Int
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        ChartFactory.lineChartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        
        
    }
    
    // get the chart entry from results
    func loadChartEntry() {
        // let records: [[String: Any]] = LocalResults.localResults["GBBI-0001"]!
        print(LocalResults.localResults[patientID]!)
        let records: [[String: Any]] = LocalResults.localResults[patientID]!
        
        for i in 0..<records.count {
            
            let dateValue = records[i]["date"] as! String
            
            print(dateValue)
            ChartFactory.dateArray.append(dateValue)
            
            let score = records[i]["hadsScore"] as? [String: Int]
            
            let depressionScore = score!["depression"]!
            print(depressionScore)
            let depressionValue = ChartDataEntry(x: Double(i), y: Double(depressionScore))
            ChartFactory.depressionScoreEntry.append(depressionValue)
            
            let anxietyScore = score!["anxiety"]!
            print(anxietyScore)
            let anxietyValue = ChartDataEntry(x: Double(i), y: Double(anxietyScore))
            ChartFactory.anxietyScoreEntry.append(anxietyValue)
        }
        
        
        
    }
    
    // format the result in the needed style
    func formatResults() -> [String: Any] {
        
        var formattedResult = [String: Any]()
        
        formattedResult["date"] = thisResult["date"]
        formattedResult["hadsScore"] = thisResult["hadsScore"]
        
        return formattedResult
    }
    
}
