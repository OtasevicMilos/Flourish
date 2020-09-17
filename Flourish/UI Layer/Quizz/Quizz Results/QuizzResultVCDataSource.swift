//
//  QuizzResultVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit


protocol QuizzResultVCDataSourceDependecies {
    var testResultsUseCase: TestResultsUseCase {get}
}

protocol QuizzResultVCDataSourceFeedBack{
    func dataUpdate()
    func showSingleCategory(_ data: SingleResult, categoryColor: UIColor)
}

class QuizzResultVCDataSource: NSObject{
    let dependecies: QuizzResultVCDataSourceDependecies
    var feedback: QuizzResultVCDataSourceFeedBack?
    var tesResult: TestResult?
    var totalScore = 0
    var selfAwareness = 0
    var selfManagment = 0
    var socialAwareness = 0
    var relationshipManagement = 0
    
    init(dependecies: QuizzResultVCDataSourceDependecies) {
        self.dependecies = dependecies
    }
    
    func getAllCategories(){
        self.dependecies.testResultsUseCase.getAllCategory { [weak self] response in
            switch response{
            case .success(let result):
                self?.tesResult = result
                self?.setValues()
                self?.feedback?.dataUpdate()
                print(result)
            case .error(let error):
                print(error)
            }
        }
    }
        
        func getSingleCategory(categoryID: Int, categoryColor: UIColor){
            self.dependecies.testResultsUseCase.singleCategory(categoryID: categoryID) { [weak self] response in
                switch response {
                case .success(let res):
                    self?.feedback?.showSingleCategory(res, categoryColor: categoryColor)
                case .error(let error):
                    print(error)
                }
            }
        }
    
    
    
    private func setValues(){
        guard let testResult = self.tesResult else {return}
        if let totalS = Double(testResult.totalAvg){
            self.totalScore = Int(totalS)
        }
        if let selfAwar = Double(testResult.selfAwarenes.selfAwarenessAvg){
            self.selfAwareness = Int(selfAwar)
        }
        
        if let selfMana = Double(testResult.selfManagement.selfManagementAvg){
            self.selfManagment = Int(selfMana)
        }
        
        if let socialAwar = Double(testResult.socialAwareness.socialAwarenessAvg){
            self.socialAwareness = Int(socialAwar)
        }
        
        if let relatioshipManag = Double(testResult.relationshipManagement.relationshipManagementAvg){
            self.relationshipManagement = Int(relatioshipManag)
        }
    }
    
}//class
