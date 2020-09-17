//
//  VerificationInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 11/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class VerificationInteractor: VerificationUseCase{
    let provider: VerificationProviderProtocol
    
    init(provider: VerificationProviderProtocol){
        self.provider = provider
    }
    
    func verifyMail(code: String, id: Int, completion: @escaping (Response<String>) -> ()){
        self.provider.verifyMail(code: code, id: id, completion:completion)
    }
    func resetCode(id: Int, completion: @escaping (Response<Bool>) -> ()){
        self.provider.resetCode(id: id, completion: completion)
    }
}
