//
//  AppJson.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppJson {
    
    /// Read json files
    ///
    /// - Parameter name: String
    /// - Returns: JSON SwiftyJson
    static func readJson(_ name: String) ->JSON {
        var result:JSON!
        
        do {
            if let file = Bundle.main.url(forResource: name, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                result = JSON(json)
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }
    
    /// Read json files
    ///
    /// - Parameters:
    ///   - name: String
    ///   - key: String
    /// - Returns: JSON SwiftyJson
    static func readJson(_ name: String, key: String) ->JSON {
        var result:JSON!
        
        do {
            if let file = Bundle.main.url(forResource: name, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                result = JSON(json)
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return result[key]
    }
    
}
