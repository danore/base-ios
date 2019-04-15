//
//  Response.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Response {
    
    /// Serialize login response
    ///
    /// - Parameter json: JSON SwiftyJSON
    /// - Returns: ResponseEntity custom object
    static func login(_ json: JSON) ->ResponseEntity {
        let response = ResponseEntity()
        
        if(json !=  JSON.null){
            let httpCode = json["code"].intValue
            let httpMessage = json["msg"].stringValue
            
            response.code = httpCode
            
            if(httpCode == HttpCode.success.rawValue){
                let recordset = json["recordset"]
                
                response.status = .success
                response.msg = "success"
                response.recordset = recordset
            }else if(httpCode == HttpCode.bad_request.rawValue){
                response.status = .error
                response.msg = httpMessage
            }else if(httpCode == HttpCode.authorized.rawValue){
                response.msg = httpMessage
            }else if(httpCode == HttpCode.forbidden.rawValue){
                response.status = .error
                
                if(httpMessage.elementsEqual("Forbidden")){
                    response.msg = "Contraseña incorrecta"
                }else{
                    response.msg = httpMessage
                }
            }else if(httpCode == HttpCode.not_found.rawValue){
                response.status = .error
                response.msg = httpMessage
            }else if(httpCode == HttpCode.method_not_allowed.rawValue){
                response.status = .error
                response.msg = httpMessage
            }else if(httpCode == HttpCode.server_error.rawValue){
                response.status = .error
                response.msg = AppString.SERVER_ERROR
            }else{
                response.status = .error
                response.msg = AppString.CRITICAL_ERROR
            }
        }else{
            response.code = HttpCode.server_error.rawValue
            response.status = .error
            response.msg = AppString.CRITICAL_ERROR
        }
        
        return response
    }
    
    /// Serialize general response
    ///
    /// - Parameter json: JSON SwiftyJSON
    /// - Returns: ResponseEntity custom object
    static func general(_ json: JSON) ->ResponseEntity {
        let response = ResponseEntity()
        
        if(json !=  JSON.null){
            let httpCode = json["code"].intValue
            let httpMessage = json["msg"].stringValue
            
            response.code = httpCode
            
            if(httpCode == HttpCode.success.rawValue || httpCode == HttpCode.created.rawValue){
                let recordset = json["recordset"]
                
                response.status = .success
                response.msg = "success"
                response.recordset = recordset
            }else if(httpCode == HttpCode.bad_request.rawValue){
                response.msg = httpMessage
            }else if(httpCode == HttpCode.authorized.rawValue){
                response.msg = httpMessage
            }else if(httpCode == HttpCode.forbidden.rawValue){
                response.status = .error
                
                if(httpMessage.elementsEqual("Forbidden")){
                    response.msg = "Datos incorrectos"
                }else{
                    response.msg = httpMessage
                }
            }else if(httpCode == HttpCode.not_found.rawValue){
                response.status = .error
                response.msg = httpMessage
            }else if(httpCode == HttpCode.method_not_allowed.rawValue){
                response.status = .error
                
                if(httpMessage.elementsEqual("Not found")){
                    response.msg = "No existen resultados"
                }else{
                    response.msg = httpMessage
                }
            }else if(httpCode == HttpCode.server_error.rawValue){
                response.status = .error
                response.msg = AppString.SERVER_ERROR
            }else{
                response.status = .error
                response.msg = AppString.CRITICAL_ERROR
            }
        }else{
            response.code = HttpCode.server_error.rawValue
            response.status = .error
            response.msg = AppString.CRITICAL_ERROR
        }
        
        return response
    }
    
}
