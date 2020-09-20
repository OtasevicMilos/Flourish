//
//  DialogueMaestroVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation
protocol DialogueMaestroVCDataSourceDependecies {
    var dialogueMaestroUseCase: DialogueMasterUseCase { get}
}

class DialogueMaestroVCDataSource{
    let dependencies: DialogueMaestroVCDataSourceDependecies
    
    
    
    init(dependencies: DialogueMaestroVCDataSourceDependecies){
        self.dependencies = dependencies
    }
    
    func getHomeInformation(completion: @escaping (Response<DialogueMaster>) -> ()){
        self.dependencies.dialogueMaestroUseCase.getHomeInformation { result in
            switch result{
            case .success(let res):
                completion(.success(res))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
