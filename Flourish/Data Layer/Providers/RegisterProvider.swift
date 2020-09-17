//
//  RegisterProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class RegisterProvider: MainProvider, RegisterProviderProtocol{
    func register(name: String, email: String, password: String, passwordConfirmation: String, phoneNumber: String, birthYear: String, completion: @escaping (Response<CustomResponse<Int>>) -> Void){
        guard var request = ApiRequest(endpoint: .register).urlRequest else {return}
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "name" : name,
            "email" : email,
            "password" : password,
            "password_confirmation" : passwordConfirmation,
            "phone_number" : phoneNumber,
            "birth_year" : birthYear,
            "terms_of_use" : "true"
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = body.percentEscaped().data(using: .utf8)
        webService.execute(request) { (response: Response<RegisterResponse>) in
            switch response{
            case .success(let response):
                 if let id = response.userId{
                    completion(.success(.success(id)))
                    return
                }
                 completion(.success(.error(response.message ?? "")))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

struct RegisterResponse: Decodable{
    let message: String?
    let userId: Int?
}
