//
//  VerificationVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 11/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol VerificationVCDataSourceDependencies {
    var verificationUseCase: VerificationUseCase{get}
}

class VerificationVCDataSource{
    let dependencies: VerificationVCDataSourceDependencies
    let userID: Int
    
    init(dependencies: VerificationVCDataSourceDependencies, userID: Int){
        self.dependencies = dependencies
        self.userID = userID
    }
    
    func verifyMail(code: String, completion: @escaping (Response<String>) -> ()){
        self.dependencies.verificationUseCase.verifyMail(code: code, id: userID, completion: completion)
    }
    
    func resetCode(){
        self.dependencies.verificationUseCase.resetCode(id: self.userID) { response in
            print(response)
        }
    }
}
