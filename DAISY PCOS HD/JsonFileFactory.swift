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
                print(data)
                json = try? JSONSerialization.jsonObject(with: data)
                print(json!)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return json
    }
    
    static func writeJSONToFile(fileName: String, dictionary: Dictionary<String, Any>) {
        
        cleanJsonFile(fileName: fileName)
        
        let json = JSON(dictionary)
        print(json)
        let str = json.description
        let data = str.data(using: .utf8)!
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        if let file = FileHandle(forWritingAtPath: path!) {
            file.write(data)
        }
    }
    
    
    // Delete the json file, and create an empty file for new data
    // Otherwise the format may be damaged due to uncomplete overwrite
    static func cleanJsonFile(fileName: String) {
        
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!

        do {
            try FileManager().removeItem(atPath: path)
            FileManager().createFile(atPath: path, contents: nil, attributes: nil)
        } catch {
            print(error)
        }
    }
    
    
}
