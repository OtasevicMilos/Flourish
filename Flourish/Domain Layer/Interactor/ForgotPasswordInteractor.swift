//
//  ForgotPasswordInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class ForgotPasswordInteractor: ForgotPasswordUseCase{
    let provider: ForgotPasswordProviderProtocol
    
    init(provider: ForgotPasswordProviderProtocol){
        self.provider = provider
    }
    
    func resetPassword(mail: String, completion: @escaping (Response<CustomResponse<String>>) -> ()) {
        provider.resetPassword(mail: mail, completion: completion)
    }
}
