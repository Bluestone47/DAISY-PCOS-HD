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
        
        ChartFactory.depressionDataSet = LineChartDataSet(values: ChartFactory.depressionScoreEntry, label: "Depression")
        ChartFactory.depressionDataSet.axisDependency = .left // Line will correlate with left axis values
        ChartFactory.depressionDataSet.setColor(UIColor.green.withAlphaComponent(0.5))
        ChartFactory.depressionDataSet.setCircleColor(UIColor.green)
        ChartFactory.depressionDataSet.lineWidth = 2.0
        ChartFactory.depressionDataSet.circleRadius = 6.0
        ChartFactory.depressionDataSet.fillAlpha = 65 / 255.0
        ChartFactory.depressionDataSet.fillColor = UIColor.green
        ChartFactory.depressionDataSet.highlightColor = UIColor.white
        
        ChartFactory.anxietyDataSet = LineChartDataSet(values: ChartFactory.anxietyScoreEntry, label: "Anxiety")
        ChartFactory.anxietyDataSet.axisDependency = .left // Line will correlate with left axis values
        ChartFactory.anxietyDataSet.setColor(UIColor.blue.withAlphaComponent(0.5))
        ChartFactory.anxietyDataSet.setCircleColor(UIColor.blue)
        ChartFactory.anxietyDataSet.lineWidth = 2.0
        ChartFactory.anxietyDataSet.circleRadius = 6.0
        ChartFactory.anxietyDataSet.fillAlpha = 65 / 255.0
        ChartFactory.anxietyDataSet.fillColor = UIColor.blue
        ChartFactory.anxietyDataSet.highlightColor = UIColor.white
        
        ChartFactory.lineChartData.addDataSet(ChartFactory.depressionDataSet)
        ChartFactory.lineChartData.addDataSet(ChartFactory.anxietyDataSet)
        
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
