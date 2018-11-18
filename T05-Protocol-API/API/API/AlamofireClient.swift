//
//  AlamofireClient.swift
//  API
//
//  Created by lili on 2018/11/18.
//  Copyright © 2018 fun. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamofireClient: Client {
    func send<T: Request>(_ req: T, handler: @escaping (HTTPResult<T.Response>) -> Void) -> URLSessionTask?
    func load<T: Request>(_ req: T, handler: @escaping (T.Response?) -> Void) -> URLSessionTask?
}

class NovelMeClient: AlamofireClient {
    
    @discardableResult
    func send<T: Request>(_ req: T, handler: @escaping (HTTPResult<T.Response>) -> Void) -> URLSessionTask? {
        let completionHandler: (DataResponse<Any>) -> Void = { response in
            if let error = response.error {
                handler(.failure(error))
                return
            }
            guard let data = response.data else {
                print("[NovelMeClient] Response success but not found data!")
                return
            }
            do {
                let dataResponse = try JSONDecoder().decode(HTTPResponse<T.Response>.self, from: data)
                handler(.success(dataResponse.result))
            } catch {
                handler(.failure(error))
            }
        }
        return send(req, completionHandler: completionHandler)
    }
    
    @discardableResult
    func load<T: Request>(_ req: T, handler: @escaping (T.Response?) -> Void) -> URLSessionTask? {
        let completionHandler: (DataResponse<Any>) -> Void = { response in
            if let error = response.error {
                print("[NovelMeClient] \(error)")
                handler(nil)
                return
            }
            guard let data = response.data else {
                print("[NovelMeClient] Response success but not found data!")
                handler(nil)
                return
            }
            do {
                let dataResponse = try JSONDecoder().decode(HTTPResponse<T.Response>.self, from: data)
                handler(dataResponse.result)
            } catch {
                print("[NovelMeClient] \(error)")
                handler(nil)
            }
        }
        return send(req, completionHandler: completionHandler)
    }
    
    private func send<T: Request>(_ req: T, completionHandler: @escaping (DataResponse<Any>) -> Void) -> URLSessionTask? {
        var parameters: [String : Any] = ["reqId": UUID().uuidString,
                                          "timestamp": Int64(Date().timeIntervalSince1970 * 1000)]
        
        if let p = req.parameters {
            parameters["param"] = p
        }
        
        return Alamofire
            .request(
                host + req.path,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: req.headers
            )
            .responseJSON { dataResponse in
                if dataResponse.response?.statusCode == 401 {
                    AuthManager.forceLogout()
                } else {
                    completionHandler(dataResponse)
                }
            }
            .task
    }
}

