//
//  Uri.swift
//  base
//
//  Created by Desarrollo on 4/12/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation

class Uri {
    
    private let isProd = true
    
    /// Uri login
    var login: String {
        return "\(self.getBaseUrl())/login"
    }
    
    /// Get base url
    ///
    /// - Returns: String
    private func getBaseUrl() ->String{
        var url = ""
        
        if(self.isProd){
            url = ""
        }else{
            url = ""
        }
        
        return url
    }
    
}
