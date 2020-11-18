//
//  HttpCode.swift
//  base
//
//  Created by Desarrollo on 4/12/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation

enum HttpCode: Int {
    
    case success
    case created
    case not_content
    case bad_request
    case authorized
    case forbidden
    case not_found
    case method_not_allowed
    case server_error
    
    /// Get http code
    ///
    /// - Parameter httpCode: Int http code
    /// - Returns:  HttpCode custon class
    static func code(_ httpCode: Int) ->HttpCode {
        switch httpCode {
        case 200:
            return .success
        case 201:
            return .created
        case 204:
            return .not_content
        case 400:
            return .bad_request
        case 401:
            return .authorized
        case 403:
            return .forbidden
        case 404:
            return .not_found
        case 405:
            return .method_not_allowed
        default:
            return .server_error
        }
    }
    
}
