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
    
    static var depressionData = LineChartData()
    static var anxietyData = LineChartData()
    
    func loadChartData() {
        
        ChartFactory.depressionDataSet = LineChartDataSet(values: ChartFactory.depressionScoreEntry, label: "Depression")
        ChartFactory.anxietyDataSet = LineChartDataSet(values: ChartFactory.anxietyScoreEntry, label: "Anxiety")
        
        ChartFactory.depressionData.addDataSet(ChartFactory.depressionDataSet)
        ChartFactory.anxietyData.addDataSet(ChartFactory.anxietyDataSet)
        
    }
    
    // get the chart entry from results
    func loadChartEntry() {
        // let records: [[String: Any]] = LocalResults.localResults["GBBI-0001"]!
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
