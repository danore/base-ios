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
    ///   - completionHandler: (JSON)
    func post(_ url: String, params: Parameters, completionHandler: @escaping (JSON) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(httpCode == HttpCode.success.rawValue || httpCode == HttpCode.created.rawValue){
                        let jsonData = try! JSON(data: response.data!)

                        completionHandler(jsonData)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)

                            completionHandler(jsonData)
                        }else{
                            completionHandler(JSON.null)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null)
                }
        }
    }
    
    /// Method http put
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameteres
    ///   - completionHandler: (JSON)
    func put(_ url: String, params: Parameters, completionHandler: @escaping (JSON) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode

                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)

                        completionHandler(jsonData)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)

                            completionHandler(jsonData)
                        }else{
                            completionHandler(JSON.null)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null)
                }
        }
    }

    /// Method http patch
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameteres
    ///   - completionHandler: (JSON)
    func patch(_ url: String, params: Parameters, completionHandler: @escaping (JSON) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode
                    
                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData)
                        }else{
                            completionHandler(JSON.null)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null)
                }
        }
    }

    /// Method http get
    ///
    /// - Parameters:
    ///   - url: String
    ///   - completionHandler: (JSON)
    func get(_ url: String, completionHandler: @escaping (JSON) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .get, encoding: JSONEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode
                    
                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData)
                        }else{
                            completionHandler(JSON.null)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null)
                }
        }
    }

    /// Method http get
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameters Almofire
    ///   - completionHandler: (JSON)
    func get(url: String, params: Parameters, completionHandler: @escaping (JSON) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .get, parameters: params, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode
                    
                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData)
                        }else{
                            completionHandler(JSON.null)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null)
                }
        }
    }

    /// Method http delete
    ///
    /// - Parameters:
    ///   - url: String
    ///   - params: Parameteres
    ///   - completionHandler: (JSON)
    func delete(_ url: String, params: Parameters, completionHandler: @escaping (JSON) -> ()) {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15

        manager.request(url, method: .delete, parameters: params, encoding: URLEncoding.default, headers: self.getHeaders())
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    let httpCode = response.response?.statusCode
                    
                    if(httpCode == HttpCode.success.rawValue){
                        let jsonData = try! JSON(data: response.data!)
                        
                        completionHandler(jsonData)
                    }else if(httpCode == HttpCode.authorized.rawValue){
                        completionHandler(JSON.null)
                    }else{
                        if(response.data!.count > 0){
                            let jsonData = try! JSON(data: response.data!)
                            
                            completionHandler(jsonData)
                        }else{
                            completionHandler(JSON.null)
                        }
                    }
                case .failure(_):
                    completionHandler(JSON.null)
                }
        }
    }
    
}
