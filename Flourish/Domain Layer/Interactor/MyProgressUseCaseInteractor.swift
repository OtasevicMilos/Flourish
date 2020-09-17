//
//  MyProgressUseCaseInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class MyProgressUseCaseInteractor: MyProgressUseCase{
    let provider: MyProgressProviderProtocol
    
    init(provider: MyProgressProviderProtocol){
        self.provider = provider
    }
    
    func getScores(completion: @escaping ((Response<Score>) -> ())) {
        self.provider.getScores(completion: completion)
    }
}
