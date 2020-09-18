//
//  MyProgressVCDataSource.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit
import SDWebImage

protocol MyProgressVCDataSourceDependencies{
    var myProgressUseCase: MyProgressUseCase{get}
}

protocol MyProgressVCDataSourceFeedback{
    func reloadData()
    func startDialogueMaestro()
}

class MyProgressVCDataSource: NSObject{
    let dependecies: MyProgressVCDataSourceDependencies
    var feedback: MyProgressVCDataSourceFeedback?
    var score: Score?
    init(dependecies: MyProgressVCDataSourceDependencies){
        self.dependecies = dependecies
    }
    
    func fetchData(){
        self.dependecies.myProgressUseCase.getScores { [weak self] response in
            switch response{
            case .success(let score):
                self?.score = score
                self?.feedback?.reloadData()
            case .error(let error):
                break
            }
        }
    }
    
    let images = [UIImage(named: "testProfileImage1"), UIImage(named: "GameCardTest"), UIImage(named: "testProfileImage2")]
    let topCellID = "topProgressTableViewCell"
    let gameCardID = "gameCardTableViewCell"
}//class

//MARK: UITableViewDataSource
extension MyProgressVCDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (score?.games.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: self.topCellID, for: indexPath)
            guard  let topCell = cell as? TopProgressTableViewCell else {
                return cell
            }
            if let user = USER{
                topCell.welcomeLabel.text = "Hi \(user.name), let’s start with training for today!"
                topCell.userImage.sd_setImage(with: URL(string: "http://flourish.proserver.me\(user.profileImage)"), placeholderImage: nil)
            }
            topCell.layer.backgroundColor = UIColor.clear.cgColor
            var socialAwareness = 0.0
            var selfAwareness = 0.0
            var selfMangement = 0.0
            var relationshipManagment = 0.0
            if self.score?.categories[0].userResults.count ?? 0 > 0{
                socialAwareness = Double(self.score?.categories[0].userResults[0].result ?? "0.0") ?? 0.0
            }
            if self.score?.categories[1].userResults.count ?? 0 > 0{
                selfAwareness = Double(self.score?.categories[1].userResults[0].result ?? "0.0") ?? 0.0
            }
            if self.score?.categories[2].userResults.count ?? 0 > 0{
                selfMangement = Double(self.score?.categories[2].userResults[0].result ?? "0.0") ?? 0.0
            }
            if self.score?.categories[3].userResults.count ?? 0 > 0{
                relationshipManagment = Double(self.score?.categories[3].userResults[0].result ?? "0.0") ?? 0.0
            }
            topCell.setAttributesView(socialAwareness: socialAwareness , selfAwareness: selfAwareness, selfMangement: selfMangement, relationshipManagment: relationshipManagment)
            return topCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: self.gameCardID, for: indexPath)
        guard  let gameCardCell = cell as? GameCardTableViewCell else {
            return cell
        }
        gameCardCell.layer.backgroundColor = UIColor.clear.cgColor
        gameCardCell.titleLable.text = score?.games[indexPath.row - 1].translations[0].title
        if indexPath.row == 1 {
            gameCardCell.callback = {
                self.feedback?.startDialogueMaestro()
            }
        }else{
            gameCardCell.callback = {}
        }
        gameCardCell.gameImage.image = images[indexPath.row - 1]
        return gameCardCell
        
    }
}
