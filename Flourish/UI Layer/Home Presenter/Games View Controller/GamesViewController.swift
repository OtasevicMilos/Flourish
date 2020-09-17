//
//  GamesViewController.swift
//  Flourish
//
//  Created by Janko on 08/09/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "GamesHeaderCell", bundle: nil), forCellReuseIdentifier: "gamesHeaderCell")
        mainTableView.register(UINib(nibName: "GamesCategoryCell", bundle: nil), forCellReuseIdentifier: "gamesCategoryCell")
        mainTableView.register(UINib(nibName: "GamesFooterCell", bundle: nil), forCellReuseIdentifier: "gamesFooterCell")
        mainTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        mainBackgroundView.setFlourishGradien()
    }


}

extension GamesViewController: UITableViewDelegate{
    
}
extension GamesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gamesHeaderCell")
            guard let testResultsHeader = cell as? GamesHeaderCell else{return UITableViewCell()}
            return testResultsHeader
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCategoryCell")
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
                      let cell = tableView.dequeueReusableCell(withIdentifier: "gamesFooterCell")
                      guard let gamesCategoryCell = cell as? GamesFooterCell else{return UITableViewCell()}
                      return gamesCategoryCell
        default:
            return UITableViewCell()
        }
    }
    
    
}
