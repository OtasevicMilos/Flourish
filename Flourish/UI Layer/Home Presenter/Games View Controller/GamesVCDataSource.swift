//
//  GamesVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 18/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class GamesVCDataSource: NSObject{
    let gamesHeaderCellID = "gamesHeaderCell"
    let gamesCategoryCellID = "gamesCategoryCell"
    let gamesFooterCellID = "gamesFooterCell"
    
}//class

//MARK: UITableViewDataSource
extension GamesVCDataSource: UITableViewDataSource{
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: self.gamesHeaderCellID)
                guard let testResultsHeader = cell as? GamesHeaderCell else{return UITableViewCell()}
                return testResultsHeader
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: self.gamesCategoryCellID)
                guard let gamesCategoryCell = cell as? GamesCategoryCell else{return UITableViewCell()}
                return gamesCategoryCell
                case 2:
                           let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCategoryCell")
                           guard let gamesCategoryCell = cell as? GamesCategoryCell else{return UITableViewCell()}
                           return gamesCategoryCell
                case 3:
                           let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCategoryCell")
                           guard let gamesCategoryCell = cell as? GamesCategoryCell else{return UITableViewCell()}
                           return gamesCategoryCell
                case 4:
                           let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCategoryCell")
                           guard let gamesCategoryCell = cell as? GamesCategoryCell else{return UITableViewCell()}
                           return gamesCategoryCell
                case 5:
                    let cell = tableView.dequeueReusableCell(withIdentifier: self.gamesFooterCellID)
                          guard let gamesCategoryCell = cell as? GamesFooterCell else{return UITableViewCell()}
                          return gamesCategoryCell
            default:
                return UITableViewCell()
            }
        }
        
        
    }
