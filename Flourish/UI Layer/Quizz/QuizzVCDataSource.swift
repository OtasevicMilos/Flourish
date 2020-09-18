//
//  QuizzVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit
import SDWebImage

protocol QuizzVCDataSourceFeedback {
    func showResult()
}

class QuizzVCDataSource: NSObject{
    let quizz: Quizz
    let dependecies: QuizzInfoVCDataSourceDepenecies
    var feedback: QuizzVCDataSourceFeedback?
    
    init(dependecies: QuizzInfoVCDataSourceDepenecies, quizz: Quizz){
        self.dependecies = dependecies
        self.quizz = quizz
    }
    
    func finishTest(answers: [Int]){
        self.dependecies.quizzUseCase.getQuizzResults(answers: answers) { [weak self] response in
            switch response{
            case .success(let result):
                print(result)
                self?.feedback?.showResult()
            case .error(let erorr):
                print(erorr)
            }
        }
    }
}//class

//MARK: UICollectionViewDataSource
extension QuizzVCDataSource: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizz.questions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizzCell", for: indexPath)
        guard let quizzCell = cell as? QuizzViewCollectionViewCell else {return cell}
        quizzCell.questionLabel.text = quizz.questions[indexPath.row].translations[0].title  
        return quizzCell
    }
}
