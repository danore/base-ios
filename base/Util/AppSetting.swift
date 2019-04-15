//
//  AppSetting.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import SwiftyJSON

class AppSetting {
    
    /// Set params String
    ///
    /// - Parameters:
    ///   - key: String
    ///   - param: String
    class func setParam(_ key: String, param: String) {
        let defaults = UserDefaults.standard
        defaults.set(param, forKey: key)
    }
    
    /// Get params String
    ///
    /// - Parameter key: String
    /// - Returns: String
    class func getParam(_ key: String) ->String {
        let defaults = UserDefaults.standard
        let result = defaults.string(forKey: key);
        
        if(result != nil){
            return result!
        }
        
        return ""
    }
    
    /// Set params Int
    ///
    /// - Parameters:
    ///   - key: String
    ///   - param: Int
    class func setParam(_ key: String, param: Int) {
        let defaults = UserDefaults.standard
        defaults.set(param, forKey: key)
    }
    
    /// Get params Int
    ///
    /// - Parameter keyInt: String
    /// - Returns: Int
    class func getParam(_ keyInt: String) ->Int {
        let defaults = UserDefaults.standard
        let result = defaults.integer(forKey: keyInt);
        
        if(result > 0){
            return result
        }
        
        return 0
    }
    
    /// Set params Double
    ///
    /// - Parameters:
    ///   - key: String
    ///   - param: Double
    class func setParam(_ key: String, param: Double) {
        let defaults = UserDefaults.standard
        defaults.set(param, forKey: key)
    }
    
    /// Get params Double
    ///
    /// - Parameter key: String
    /// - Returns: Double
    class func getParam(_ key: String) ->Double {
        let defaults = UserDefaults.standard
        let result = defaults.double(forKey: key);
        
        if(result > 0){
            return result
        }
        
        return 0
    }
    
    /// Set param Bool
    ///
    /// - Parameters:
    ///   - key: String
    ///   - param: Bool
    class func setParam(_ key: String, param: Bool){
        let defaults = UserDefaults.standard
        defaults.set(param, forKey: key)
    }
    
    /// Get param Bool
    ///
    /// - Parameter key: String
    /// - Returns: Bool
    class func getParam(_ key: String) ->Bool {
        let defaults = UserDefaults.standard
        let result = defaults.bool(forKey: key)
        
        return result
    }
    
}
