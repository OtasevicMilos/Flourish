//
//  QuizzSingleResultViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 17/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class QuizzSingleResultViewController: UIViewController {
    let dataSource: QuizzSingleResultVCDataSource
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryProgressView: UIView!
    @IBOutlet weak var progresLabel: UILabel!
    @IBOutlet weak var shadowTopView: UIView!
    
    init(dataSource: QuizzSingleResultVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("ini")  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTable()
        self.setView()
    }
    private func setView(){
        self.categoryTitleLabel.text = self.dataSource.singleResult.questionCategoryName
        if let procent = Double(self.dataSource.singleResult.questionCategoryAvg){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
            self.categoryProgressView.makeBigCircle(Int(procent), progressCircleColor: self.dataSource.categoryColor, lineWidth: 14)
            self.progresLabel.incrementLabel(to: Int(procent))
            }
        }
            self.shadowTopView.layer.cornerRadius = 10
            self.shadowTopView.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0.8668113426)
            self.shadowTopView.layer.shadowOpacity = 20
            self.shadowTopView.layer.shadowRadius = 20
    }
    
    private func setTable(){
        self.table.delegate = self
        self.table.dataSource = self.dataSource
        self.table.register(UINib(nibName: "QuizzSingleResultTableViewCell", bundle: nil), forCellReuseIdentifier: self.dataSource.quizzCellID)
        self.table.allowsSelection = false
        self.table.separatorStyle = .none
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}//class

//MARK: UITableViewDelegate
extension QuizzSingleResultViewController: UITableViewDelegate{}
