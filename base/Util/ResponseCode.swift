//
//  ResponseCode.swift
//  base
//
//  Created by Desarrollo on 4/12/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation

class ResponseCode{
    
    /// Valid http code of services
    ///
    /// - Parameters:
    ///   - code: Int
    /// - Returns: Bool
    static func response(_ code: Int) ->Bool{
        if(code == HttpCode.success.rawValue) {
            return true
        }else if(code == HttpCode.created.rawValue){
            return true
        }else if(code == HttpCode.not_content.rawValue){
            return false
        }else if(code == HttpCode.bad_request.rawValue){
            return false
        }else if(code == HttpCode.authorized.rawValue){
            return false
        }else if(code == HttpCode.forbidden.rawValue){
            return false
        }else if(code == HttpCode.not_found.rawValue){
            return false
        }else if(code == HttpCode.method_not_allowed.rawValue){
            return false
        }else if(code == HttpCode.server_error.rawValue){
            return false
        }
        
        return false
    }
    
}
