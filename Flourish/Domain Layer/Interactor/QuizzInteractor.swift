//
//  QuizzInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class QuizzInteractor: QuizzUseCase{
    let provider: QuizzProtocolProvider
    
    init(provider: QuizzProtocolProvider){
        self.provider = provider
    }
    
    func getQuizz(completion: @escaping (Response<Quizz>) -> ()) {
        self.provider.getQuizz(completion: completion)
    }
    
    func getQuizzResults(answers: [Int], completion: @escaping (Response<Bool>) -> ()){
        self.provider.getQuizzResults(answers: answers, completion:completion)
    }
}
