//
//  LoginVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 08/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol LoginVCDataSourceDependencies {
    var loginUseCase: LoginUseCase {get}
}

class LoginVCDataSource{
    let dependencies: LoginVCDataSourceDependencies

    init(dependencies: LoginVCDataSourceDependencies){
           self.dependencies = dependencies
       }
    
    func loginUser(email: String, password: String, completion: @escaping ((Response<User>) -> ())){
        self.dependencies.loginUseCase.login(email: email, password: password, completion: completion)
//        self.dependencies.loginUseCase.login(email: email, password: password) {  [weak self] response in
//            switch response{
//            case .success( _):
//                completion(true)
//            case .error(let error):
//                print(error)
//                completion(false)
//            }
//        }
    }
}//class
