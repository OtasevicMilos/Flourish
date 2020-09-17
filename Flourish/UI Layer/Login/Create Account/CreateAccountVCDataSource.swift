//
//  CreateAccountVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 09/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol CreateAccountVCDataSourceDependencies {
    var registerUseCase: RegisterUseCase {get}
}

class CreateAccountVCDataSource{
    let dependencies: CreateAccountVCDataSourceDependencies
    
    init(dependencies: CreateAccountVCDataSourceDependencies){
        self.dependencies = dependencies
    }
    
    func register(name: String, email: String, password: String, phoneNumber: String, birthYear: String, completion: @escaping (CustomResponse<Int>) -> ()){
        self.dependencies.registerUseCase.register(name: name, email: email, password: password, passwordConfirmation: password, phoneNumber: phoneNumber, birthYear: birthYear) { [weak self] response  in
            switch response{
            case .success(let response):
               completion(response)
            case .error:
                completion(.error(""))
            }
        }
    }
}//class
