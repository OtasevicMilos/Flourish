//
//  QuizzInfoVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol QuizzVCDataSourceFeedBack{
    func updateData()
}

protocol QuizzInfoVCDataSourceDepenecies {
    var quizzUseCase: QuizzUseCase {get}
}

class QuizzInfoVCDataSource{
    let dependecies: QuizzInfoVCDataSourceDepenecies
    var feedback: QuizzVCDataSourceFeedBack?
    var quizz: Quizz?
    
    init(dependecies: QuizzInfoVCDataSourceDepenecies){
        self.dependecies = dependecies
    }
    
    func getQuizz(){
        self.dependecies.quizzUseCase.getQuizz { [weak self] response in
            switch response{
            case .success(let quizz):
                self?.quizz = quizz
                self?.feedback?.updateData()
            case .error(let error):
                print(error)
            }
        }
    }
    
}
