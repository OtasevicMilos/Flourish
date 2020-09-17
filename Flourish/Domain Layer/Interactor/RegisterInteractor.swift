//
//  RegisterInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class RegisterInteractor: RegisterUseCase{
    let provider: RegisterProviderProtocol
    
    init(provider: RegisterProviderProtocol){
        self.provider = provider
    }
    
   func register(name: String, email: String, password: String, passwordConfirmation: String, phoneNumber: String, birthYear: String, completion: @escaping (Response<CustomResponse<Int>>) -> Void) {
    self.provider.register(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation, phoneNumber: phoneNumber, birthYear: birthYear, completion: completion)
   }
   
}
