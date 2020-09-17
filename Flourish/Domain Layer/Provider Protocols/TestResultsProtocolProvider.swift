//
//  TestResultsProtocolProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol TestResultsProtocolProvider {
    func getAllCategory(completion: @escaping (Response<TestResult>) -> ())
    func singleCategory(categoryID: Int, completion: @escaping (Response<SingleResult>) -> ())
}
