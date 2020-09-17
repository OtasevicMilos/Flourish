//
//  DialogueMasterResultUseCase.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol DialogueMasterResultUseCase{
    func getResult(points: [Int], completion: @escaping (Response<DMResult>) -> ())
}
