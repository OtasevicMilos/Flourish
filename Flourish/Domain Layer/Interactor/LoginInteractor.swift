//
//  LoginInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class LoginInteractor: LoginUseCase{
    let provider: LoginProviderProtocol
    
    init(provider: LoginProviderProtocol){
        self.provider = provider
    }
    
    func login(email: String, password: String, completion: @escaping (Response<User>) -> Void) {
        self.provider.login(email: email, password: password, completion: completion)
       }
   
}
