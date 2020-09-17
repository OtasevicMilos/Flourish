//
//  TestResultsInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class  TestResultsInteractor: TestResultsUseCase {
    let provider: TestResultsProtocolProvider
    
    init(provider: TestResultsProtocolProvider) {
        self.provider = provider
    }
    
    func getAllCategory(completion: @escaping (Response<TestResult>) -> ()) {
        self.provider.getAllCategory(completion: completion)
    }
    
    func singleCategory(categoryID: Int, completion: @escaping (Response<SingleResult>) -> ()) {
        self.provider.singleCategory(categoryID: categoryID, completion: completion)
    }
    
}
