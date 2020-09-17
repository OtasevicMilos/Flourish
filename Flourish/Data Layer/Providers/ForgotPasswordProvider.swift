//
//  ForgotPasswordProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class ForgotPasswordProvider: MainProvider, ForgotPasswordProviderProtocol {
    func resetPassword(mail: String, completion: @escaping (Response<CustomResponse<String>>) -> ()) {
        guard var request = ApiRequest(endpoint: .resetPassword).urlRequest else {return }
        request.httpMethod = "POST"
        
        let body: [String: Any] = [
            "email" : mail
        ]
        request.httpBody = body.percentEscaped().data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        webService.execute(request) { (response: Response<ForgotPasswordResponse>) in
            switch response{
            case .success(let res):
                completion(.success(.success(res.status)))
            case .error(let error):
                completion(.error(error))
                
            }
        }
    }
}

struct ForgotPasswordResponse: Codable {
    let status: String
}
