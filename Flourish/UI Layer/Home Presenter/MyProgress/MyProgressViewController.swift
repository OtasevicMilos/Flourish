//
//  MyProgressViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 09/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol MyProgressViewControllerDelegate {
    func startDialogueMaestro()
}

class MyProgressViewController: UIViewController {
    let dataSource: MyProgressVCDataSource
    var delegate: MyProgressViewControllerDelegate?
    @IBOutlet weak var table: UITableView!
    
    init(dataSource: MyProgressVCDataSource){
        self.dataSource = dataSource
          super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) { fatalError("init") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView()
    }
    
    private func tableView(){
        self.dataSource.fetchData()
        self.table.dataSource = self.dataSource
        self.table.register(UINib(nibName: "TopProgressTableViewCell", bundle: nil), forCellReuseIdentifier: self.dataSource.topCellID)
        self.table.register(UINib(nibName: "GameCardTableViewCell", bundle: nil), forCellReuseIdentifier: self.dataSource.gameCardID)
        self.table.delegate = self
        self.dataSource.feedback = self
        self.table.separatorStyle = .none
        self.table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
         self.view.setFlourishGradien(withColors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9921568627, green: 0.8901960784, blue: 1, alpha: 1).cgColor ], start: CGPoint(x: 0.5, y:0), end: CGPoint(x:0.5, y: 1))
        self.table.allowsSelection = false

    }
}//class

//MARK: UITableViewDelegate
extension MyProgressViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK: MyProgressVCDataSourceFeedback
extension MyProgressViewController: MyProgressVCDataSourceFeedback{
    
    func startDialogueMaestro() {
        self.delegate?.startDialogueMaestro()
    }
    
    func reloadData() {
        self.table.reloadData()
    }
}
