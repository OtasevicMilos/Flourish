//
//  MyProgressUseCase.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol MyProgressUseCase{
    func getScores(completion: @escaping ((Response<Score>) -> ()))
}

