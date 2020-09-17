//
//  VerificationProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 11/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class VerificationProvider: MainProvider, VerificationProviderProtocol{
    
    func verifyMail(code: String, id: Int, completion: @escaping (Response<String>) -> ()) {
        guard var request = ApiRequest(endpoint: .verifyMail).urlRequest else {return}
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "verification_code" : code,
            "userId" : id
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body.percentEscaped().data(using: .utf8)

        webService.execute(request) { (response: Response<VerificationRespone>) in
            switch response{
            case .success(let res):
                guard let success = res.status else{
                    completion(.error(WebServiceError.serverError))
                    return
                }
                completion(.success(success))
            case .error(let error):
                completion(.error(error))
            }
        }
        
    }
    
    func resetCode(id: Int, completion: @escaping (Response<Bool>) -> ()){
        guard var request = ApiRequest(endpoint: .resetCode(userID: id)).urlRequest else {return}
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        webService.execute(request) { (response: Response<VerificationRespone>) in
            switch response{
            case .success(let res):
                completion(.success(res.status != nil))
            case .error(let error):
                completion(.error(error))
            }
        }
        
    }
}

struct VerificationRespone: Decodable {
    let status: String?
}
