//
//  ResponseEntity.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseEntity {
    
    var status: HttpStatus!
    var code: Int!
    var msg: String!
    var recordset: JSON!
    
}
