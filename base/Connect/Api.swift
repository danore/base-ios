//
//  Api.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Api {
    
    /// Login app
    ///
    /// - Parameters:
    ///   - params: Parameters Alamofire
    ///   - completionHandler: (JSON)
    static func login(_ params: Parameters, completionHandler: @escaping (JSON, HttpCode) -> ()){
        Connect.shared.request(Uri().login, httpMethod: .post, completionHandler: completionHandler)
    }
    
}
