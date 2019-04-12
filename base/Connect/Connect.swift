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
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var token = ""
    
    /// Get params header
    ///
    /// - Returns: HTTPHeaders
    private func getHeaders() ->HTTPHeaders{
        return [
            "Authorization": "\(self.token)"
        ]
    }
    
    /// Method http post
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameteres
    ///   - completionHandler: CompletionHandler
    func post(_ url: String, params: Parameters, completionHandler: @escaping (JSON, Int) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(httpCode == HttpCode.success.rawValue || httpCode == HttpCode.created.rawValue){
                        let jsonData = try! JSON(data: response.data!)

                        completionHandler(jsonData, httpCode!)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null, httpCode!)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)

                            completionHandler(jsonData, httpCode!)
                        }else{
                            completionHandler(JSON.null, httpCode!)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null, HttpCode.server_error.rawValue)
                }
        }
    }
    
    /// Method http put
    ///
    /// - Parameters:
    ///   - url: String
    ///   - controller: String
    ///   - params: Parameteres
    ///   - type: Int
    ///   - completionHandler: CompletionHandler
    func put(_ url: String, params: Parameters, completionHandler: @escaping (JSON, Int) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)

                        completionHandler(jsonData, httpCode!)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null, httpCode!)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)

                            completionHandler(jsonData, httpCode!)
                        }else{
                            completionHandler(JSON.null, httpCode!)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null, HttpCode.server_error.rawValue)
                }
        }
    }

    /// Method http patch
    ///
    /// - Parameters:
    ///   - url: String
    ///   - controller: String
    ///   - params: Parameteres
    ///   - type: Int
    ///   - completionHandler: CompletionHandler
    func patch(_ url: String, params: Parameters, completionHandler: @escaping (JSON, Int) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData, httpCode!)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null, httpCode!)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData, httpCode!)
                        }else{
                            completionHandler(JSON.null, httpCode!)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null, HttpCode.server_error.rawValue)
                }
        }
    }

    /// Method http get
    ///
    /// - Parameters:
    ///   - url: String
    ///   - completionHandler: CompletionHandler
    func get(_ url: String, completionHandler: @escaping (JSON, Int) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .get, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData, httpCode!)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null, httpCode!)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData, httpCode!)
                        }else{
                            completionHandler(JSON.null, httpCode!)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null, HttpCode.server_error.rawValue)
                }
        }
    }

    /// Method http get
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameters Almofire
    ///   - isLogin: Bool
    ///   - isBasic: Bool
    ///   - completionHandler: (JSON, NSError?)
    func get(url: String, params: Parameters, isLogin: Bool, isBasic: Bool, completionHandler: @escaping (JSON, Int) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .get, parameters: params, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode
                    
                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData, httpCode!)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null, httpCode!)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData, httpCode!)
                        }else{
                            completionHandler(JSON.null, httpCode!)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null, HttpCode.server_error.rawValue)
                }
        }
    }

    /// Method http delete
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameteres
    ///   - completionHandler: CompletionHandler
    func delete(_ url: String, params: Parameters, completionHandler: @escaping (JSON, Int) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .delete, parameters: params, encoding: URLEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(ResponseCode.response(httpCode!)){
                        let jsonData = try! JSON(data: response.data!)

                        completionHandler(jsonData, httpCode!)
                    }else if(response.response?.statusCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null, httpCode!)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)

                            completionHandler(jsonData, httpCode!)
                        }else{
                            completionHandler(JSON.null, httpCode!)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null, HttpCode.server_error.rawValue)
                }
        }
    }
    
}
