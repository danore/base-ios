//
//  AppStoryBoard.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import UIKit

class AppStoryBoard {
    
    /// Call new controller default
    ///
    /// - Parameters:
    ///   - main: UIViewController
    ///   - controller: String
    static func call(_ main: UIViewController, controller: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: controller)
        vc.modalTransitionStyle = .crossDissolve
        
        main.present(vc, animated: true, completion: nil)
    }
    
    /// Call new controller default
    ///
    /// - Parameters:
    ///   - main: UIViewController
    ///   - controller: String
    static func callModal(_ main: UIViewController, controller: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: controller)
        vc.modalTransitionStyle = .coverVertical
        
        main.present(vc, animated: true, completion: nil)
    }
    
    /// Call default controller
    ///
    /// - Parameters:
    ///   - main: UIViewController
    ///   - controller: String
    static func callDefault(_ main: UIViewController, controller: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: controller)
        
        main.present(vc, animated: true, completion: nil)
    }
    
}
