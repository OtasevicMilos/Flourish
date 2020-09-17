//
//  ForgotPasswordVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol ForgotPasswordVCDataSourceDependecies{
    var forgotPasswordUseCase: ForgotPasswordUseCase {get}
}

class ForgotPasswordVCDataSource{
    let dependecies: ForgotPasswordVCDataSourceDependecies
    
    init(dependecies: ForgotPasswordVCDataSourceDependecies) {
        self.dependecies = dependecies
    }
    
    func resetPassword(mail: String, completion: @escaping (CustomResponse<String>) -> ()){
        dependecies.forgotPasswordUseCase.resetPassword(mail: mail) { response in
            switch response{
            case .success(let res):
                switch res {
                case .success:
                    completion(.success(""))
                default:
                    return
                }
            case .error(let error):
                switch error {
                case WebServiceError.noInternetConnection:
                    completion(.error("Conection error"))
                default:
                    completion(.error("Conection error"))
                }
            }
        }
    }
}
