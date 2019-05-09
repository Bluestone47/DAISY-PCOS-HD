//
//  JsonFileFactory.swift
//  DAISY PCOS HD
//
//  Created by XIAN DONG on 8/5/19.
//  Copyright © 2019 XIAN DONG. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonFileFactory {
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func convertToJson(data: Dictionary<String, Any>) -> Any? {
        var json: Any?
        json = try? JSONSerialization.data(withJSONObject: data)
        return json
    }
    
    static func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return json
    }
    
    static func writeJSONToFile(fileName: String, dictionary: Dictionary<String, Any>) {
        
        let json = JSON(dictionary)
        print(json)
        let str = json.description
        let data = str.data(using: .utf8)!
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if let file = FileHandle(forWritingAtPath: path!) {
            file.write(data)
        }
    }
    
    static func saveUploadedFilesSet(fileName: String, dictionary: [String : Any]) {
        
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let file: FileHandle? = FileHandle(forWritingAtPath: path!)
        
        if file != nil {
            // Set the data we want to write
            do{
                if let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .init(rawValue: 0)) as? Data
                {
                    // Check if everything went well
                    print(NSString(data: jsonData, encoding: 1)!)
                    // Write it to the file
                    file?.write(jsonData)
                    
                }
            }
            catch let error {
                print("parse error: \(error.localizedDescription)")
            }
            
            // Close the file
            file?.closeFile()
        }
        else {
            print("Ooops! Something went wrong!")
        }
    }
    
    static func getUploadedFileSet(filename:String) {
        if let path = Bundle.main.path(forResource: "assets/\(filename)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                    // do stuff
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
}
