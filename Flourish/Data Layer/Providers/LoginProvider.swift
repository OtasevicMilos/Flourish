//
//  LoginProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class LoginProvider: MainProvider, LoginProviderProtocol{
    func login(email: String, password: String, completion: @escaping (Response<User>) -> Void) {
        guard var request = ApiRequest(endpoint: .login).urlRequest else {return}
        request.httpMethod = "POST"
        let body: [String: Any] = [
                   "email" : email,
                   "password" : password
               ]
               
               request.setValue("application/json", forHTTPHeaderField: "Accept")
               request.httpBody = body.percentEscaped().data(using: .utf8)
        webService.execute(request) { (response: Response<LoginResponse>) in
            switch response{
            case .success(let response):
                USER = response.user
                TOKEN = response.access_token
                completion(.success(response.user))
            case .error(let error):
                completion(.error(error))
            }
        }
        
    }
}


struct LoginResponse: Decodable{
    let access_token: String
    let expires_in: Int
    let user: User
}

var TOKEN = ""
var USER: User?
