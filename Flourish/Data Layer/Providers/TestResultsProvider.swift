//
//  TestResultsProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class TestResultsProvider: MainProvider, TestResultsProtocolProvider{
    func getAllCategory(completion: @escaping (Response<TestResult>) -> ()) {
        guard var request = ApiRequest(endpoint: .allCategories).urlRequest else {return}
        
              request.setValue("application/json", forHTTPHeaderField: "Accept")
              request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
              
              webService.execute(request) { (response: Response<TestResultResponse>) in
                switch response{
                case .success(let result):
                    completion(.success(result.data))
                case .error(let error):
                    completion(.error(error))
                }
        }
    }
    
    func singleCategory(categoryID: Int, completion: @escaping (Response<SingleResult>) -> ()) {
        guard var request = ApiRequest(endpoint: .singleCategory(categoryID: categoryID)).urlRequest else {return}
        
                    request.setValue("application/json", forHTTPHeaderField: "Accept")
                    request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        
        webService.execute(request) { (response: Response<SingleResult>) in
            switch response{
            case .success(let result):
                completion(.success(result))
            case .error(let error):
                completion(.error(error))
            }
        }

    }
    
    
}

    struct TestResultResponse: Codable {
        let data: TestResult
}
