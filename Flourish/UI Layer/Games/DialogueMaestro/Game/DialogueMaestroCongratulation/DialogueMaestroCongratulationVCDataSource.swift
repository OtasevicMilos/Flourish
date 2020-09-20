//
//  DialogueMaestroCongratulationVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol DialogueMaestroCongratulationVCDataSourceDependecies {
    var dialogueMasterResultUseCase: DialogueMasterResultUseCase {get}
}

protocol DialogueMaestroCongratulationVCDataSourceFeedback {
    func updateData()
}

class DialogueMaestroCongratulationVCDataSource{
    var feedback: DialogueMaestroCongratulationVCDataSourceFeedback?
    let dependecies: DialogueMaestroCongratulationVCDataSourceDependecies
    let points: [Int]
    var result: Int?
    var procent: Double?
    
    init(dependecies: DialogueMaestroCongratulationVCDataSourceDependecies, points: [Int]){
        self.dependecies = dependecies
        self.points = points
    }
    
    func getResult(){
        self.dependecies.dialogueMasterResultUseCase.getResult(points: points) { [weak self] response in
            switch response{
            case .success(let result):
                self?.result = result.result
                self?.getProcent(result.percent)
                self?.feedback?.updateData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func getProcent(_ percent: String){
        guard  let percentDouble = Double(percent) else {
            self.procent = 0.0
            return
        }
        self.procent = percentDouble
    }
    
}
