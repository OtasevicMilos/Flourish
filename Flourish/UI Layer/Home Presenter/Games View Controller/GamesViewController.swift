//
//  GamesViewController.swift
//  Flourish
//
//  Created by Janko on 08/09/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

protocol GamesViewControllerFeedback {
    func backFromGames()
}

class GamesViewController: UIViewController {
    let dataSource: GamesVCDataSource
    var feedback: GamesViewControllerFeedback?
    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet weak var beckButtonView: UIView!
    @IBOutlet weak var beckButtonViewLeftConstraint: NSLayoutConstraint!
    
    init(dataSource: GamesVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.beckButtonViewLeftConstraint.constant = -200
    }
    
    
    private func setView(){
        self.beckButtonView.layer.cornerRadius = self.beckButtonView.bounds.width / 2
        self.beckButtonView.setFlourishGradien(withColors: [#colorLiteral(red: 0.5568627451, green: 0.9137254902, blue: 1, alpha: 1), #colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1)], start: CGPoint(x: 0, y: 1), end: CGPoint(x: 1, y: 0))
        self.beckButtonView.clipsToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.8) {
            self.beckButtonViewLeftConstraint.constant = -70
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func setTable(){
        self.mainTableView.separatorStyle = .none
        self.mainTableView.allowsSelection = false
        mainTableView.delegate = self
        mainTableView.dataSource = self.dataSource
        mainTableView.register(UINib(nibName: "GamesHeaderCell", bundle: nil), forCellReuseIdentifier: self.dataSource.gamesHeaderCellID)
        mainTableView.register(UINib(nibName: "GamesCategoryCell", bundle: nil), forCellReuseIdentifier: self.dataSource.gamesCategoryCellID)
        mainTableView.register(UINib(nibName: "GamesFooterCell", bundle: nil), forCellReuseIdentifier: self.dataSource.gamesFooterCellID)
    }

    @IBAction func beckButtonPressed(_ sender: Any) {
//            UIView.animate(withDuration: 0.8) {
            self.beckButtonViewLeftConstraint.constant = -200
//                self.view.layoutIfNeeded()
//            }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        self.feedback?.backFromGames()
//        }
    }
}//class

//MARK: UITableViewDelegate
extension GamesViewController: UITableViewDelegate{
    
}
