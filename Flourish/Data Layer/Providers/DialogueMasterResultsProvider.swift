//
//  DialogueMasterResultsProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class DialogueMasterResultsProvider: MainProvider, DialogueMasterResultProtocolProvider {
    
    func getResult(points: [Int], completion: @escaping (Response<DMResult>) -> ()) {
        guard var request = ApiRequest(endpoint: .dialogueMaestroResults).urlRequest else {return}
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        
        let body: [String: [Any]] = [
            "points" : points
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        request.httpBody = jsonData
        
        webService.execute(request) { (response: Response<DialogueMasterResultsProviderResponse>) in
            switch response{
            case .success(let ressult):
                completion(.success(DMResult(result: ressult.data.result, percent: ressult.percent)))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

struct DialogueMasterResultsProviderResponse: Codable {
    let data: DMDataResult
    let percent: String
}

struct DMDataResult: Codable {
    let result: Int
}
