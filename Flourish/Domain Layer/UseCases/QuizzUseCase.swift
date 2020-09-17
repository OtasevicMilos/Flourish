//
//  QuizzUseCase.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol QuizzUseCase {
    func getQuizz(completion: @escaping (Response<Quizz>) -> ())
    func getQuizzResults(answers: [Int], completion: @escaping (Response<Bool>) -> ())
}
