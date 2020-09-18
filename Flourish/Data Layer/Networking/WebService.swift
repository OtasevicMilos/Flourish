//
//  WebService.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation
import Reachability

protocol WebService: class{
    func execute<T: Decodable>(_ request: URLRequest, callBack: @escaping(Response<T>) -> Void)
}

class WebServiceProvide: WebService{
    private let session: NetworkSession
    
    init(session: NetworkSession){
        self.session = session
    }
    
    func execute<T>(_ request: URLRequest, callBack: @escaping (Response<T>) -> Void) where T : Decodable{
        do{
                if try Reachability()?.connection == Reachability.Connection.none{
                    callBack(.error(WebServiceError.noInternetConnection))
                    return
            }
                }catch {
                    print("ff")
                }
        session.perform(with: request) { [weak self] (data, response, error) in
            self?.handleResponse(data, httpResponse: response as? HTTPURLResponse, error: error, callback: callBack)
        }
            }
    
        private func handleResponse<T: Decodable>(_ data: Data?, httpResponse: HTTPURLResponse?, error: Error?, callback: (Response<T>) -> Void){
            if let error = error{
                callback(.error(error))
            } else if let data = data {
                if T.self == Data.self {
                    callback(.success(data as! T))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    callback(.success(result))
                }catch {
                    print(error)
                    callback(.error(WebServiceError.decodingError))
                }
            }else{
                callback(.error(WebServiceError.timeOutError))
            }
        }
    }


enum WebServiceError: Error, Equatable {
    case ambigousResponse
    case noInternetConnection
    case serverError
    case wrongCredentials
    case firstTimeLogin
    case decodingError
    case timeOutError
}
