//
//  QuizzSingleResultVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 17/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit



protocol QuizzSingleResultVCDataSourceProtocol {
    func feedback()
}

class QuizzSingleResultVCDataSource: NSObject{
    var feedback: QuizzSingleResultVCDataSourceProtocol?
    let singleResult: SingleResult
    let categoryColor: UIColor
    let quizzCellID = "quizzSingleResultTableViewCell"

    init( singleResult: SingleResult, categoryColor: UIColor){
        self.singleResult = singleResult
        self.categoryColor = categoryColor
    }
    
}//class

//MARK: UITableViewDataSource
extension QuizzSingleResultVCDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleResult.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.quizzCellID, for: indexPath)
        guard let quizzCell = cell as? QuizzSingleResultTableViewCell else { return cell }
        quizzCell.titleLabel.text = self.singleResult.questions[indexPath.row].questionTitle
        quizzCell.procentLabel.text = "\(self.singleResult.questions[indexPath.row].answer)%"
        quizzCell.backgroundColor = (indexPath.row % 2) == 0 ? #colorLiteral(red: 0.8587478995, green: 0.8588721156, blue: 0.858720839, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) 

        return quizzCell
    }
    
    
}
