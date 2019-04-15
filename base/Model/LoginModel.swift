//
//  LoginModel.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import Alamofire

class LoginModel {
    
    init(){
    }
    
    /// Login app
    ///
    /// - Parameters:
    ///   - params: Parameters Alamofire
    ///   - completion: (ResponseEntity) Custom object
    func login(_ params: Parameters, completion: @escaping (ResponseEntity) -> ()){
        Api.login(params, completionHandler: { (json) in
            completion(Response.login(json))
        })
    }
    
}
