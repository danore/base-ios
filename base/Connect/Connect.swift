//
//  Connect.swift
//  base
//
//  Created by Desarrollo on 4/12/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Connect {
    static let shared = Connect()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var token = ""
    
    private init(){}
    
    /// Get params header
    ///
    /// - Returns: HTTPHeaders
    private func getHeaders() ->HTTPHeaders{
        return [
            "Authorization": "\(self.token)"
        ]
    }
    
    /// Http Request
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameters Alamofire
    ///   - httpMethod: HTTPMethod Alamofire
    ///   - completionHandler: (JSON, HttpCode)
    func request(_ url: String, params: Parameters? = nil, httpMethod: HTTPMethod, completionHandler: @escaping (JSON, HttpCode) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15
        var request: DataRequest
                
        if(Reachability.shared.isConnectedToNetwork){
            if httpMethod == .get {
                if params != nil {
                    request = AF.request(url, method: .get, parameters: params, headers: self.getHeaders())
                }else {
                    request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: self.getHeaders())
                }
            }else if httpMethod == .post || httpMethod == .put {
                request = AF.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            }else {
                request = AF.request(url, method: .delete, parameters: params, headers: self.getHeaders())
            }
            
            request.responseJSON { response in
                self.validResponse(response) { (json, httpCode) in
                    completionHandler(json, httpCode)
                }
            }
        }else{
            completionHandler(JSON.null, .server_error)
        }
    }
    
    /// Valid response data
    /// - Parameters:
    ///   - response: DataResponse<Any>
    ///   - completion: (JSON, HttpCode)
    private func validResponse(_ response: AFDataResponse<Any>, completion: @escaping (JSON, HttpCode) -> ()) {
        switch response.result {
        case .success(_):
            let httpCode = HttpCode.code((response.response?.statusCode)!)
            let json = response.data ?? nil
            
            if (httpCode != .server_error){
                if json != nil {
                    let jsonData = try! JSON(data: response.data!)
                    
                    completion(jsonData, httpCode)
                }else {
                    completion(JSON.null, httpCode)
                }
            } else{
                completion(JSON.null, httpCode)
            }
        case .failure(_):
            if(response.response != nil){
                let httpCode = HttpCode.code((response.response?.statusCode)!)
                
                if(httpCode == .authorized){
//                    self.callLogout()
                    completion(JSON.null, httpCode)
                }else{
                    completion(JSON.null, httpCode)
                }
            }else{
                completion(JSON.null, .server_error)
            }
        }
    }
    
}
