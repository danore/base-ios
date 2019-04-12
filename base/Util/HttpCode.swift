//
//  HttpCode.swift
//  base
//
//  Created by Desarrollo on 4/12/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation

enum HttpCode: Int {
    
    case success = 200
    case created = 201
    case not_content = 204
    case bad_request = 400
    case authorized = 401
    case forbidden = 403
    case not_found = 404
    case method_not_allowed = 405
    case server_error = 500
    
}
