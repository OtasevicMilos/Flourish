//
//  MyProgressProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class MyProgressProvider: MainProvider, MyProgressProviderProtocol{
    
    func getScores(completion: @escaping ((Response<Score>) -> ())) {
        guard var request = ApiRequest(endpoint: .homeScreen).urlRequest else {return}
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        
        webService.execute(request) { (response: Response<Score>) in
            switch response{
            case .success(let score):
                completion(.success(score))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

