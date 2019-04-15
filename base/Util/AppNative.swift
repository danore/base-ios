//
//  AppNative.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import UIKit

class AppNative {
    
    /// Call number
    ///
    /// - Parameter number: Int
    static func call(_ number: Int){
        guard let number = URL(string: "telprompt://\(number)") else { return }
        UIApplication.shared.open(number, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    /// Call number
    ///
    /// - Parameter number: String
    static func call(_ number: String){
        guard let number = URL(string: "tel://\(number.replacingOccurrences(of: " ", with: ""))") else { return }
        UIApplication.shared.open(number, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    /// Send sms
    ///
    /// - Parameter number: Int
    static func sms(_ number: Int){
        UIApplication.shared.open(NSURL(string: "sms:\(number)")! as URL)
    }
    
    /// Call to number extension
    ///
    /// - Parameters:
    ///   - number: Int
    ///   - ext: Int
    static func phoneExtension(_ number: Int, ext: Int){
        if let phoneCallURL = URL(string: "tel://\(number),\(ext)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

