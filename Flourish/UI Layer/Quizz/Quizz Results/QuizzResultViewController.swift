//
//  QuizzResultViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol QuizzResultViewControllerDelegate {
    func showSingleCategory(_ singleResult: SingleResult, categoryColor: UIColor)
    func showHome()
}

class QuizzResultViewController: UIViewController {
    let dataSource: QuizzResultVCDataSource
    var delegate: QuizzResultViewControllerDelegate?
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var totalScore: UIView!
    @IBOutlet weak var selfAwarenessCircleView: UIView!
    @IBOutlet weak var selfManagmentCircleView: UIView!
    @IBOutlet weak var socialAwarenessCircleView: UIView!
    @IBOutlet weak var relationshipManagementCircleView: UIView!
    @IBOutlet weak var checkAreasLabel: UILabel!
    @IBOutlet weak var checkAreasView: UIView!
    @IBOutlet weak var chooseAreas: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scoreByCategoriesView: UIView!
    @IBOutlet weak var averageTotalScoreLabel: UILabel!
    @IBOutlet weak var selfAwaeenessLabel: UILabel!
    @IBOutlet weak var selfManagementLabel: UILabel!
    @IBOutlet weak var socialAwarenessLabel: UILabel!
    
    @IBOutlet weak var relationshipManagementLabel: UILabel!
    init(dataSource: QuizzResultVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {fatalError("init")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.feedback = self
        self.dataSource.getAllCategories()
    }
    
    private func setView(){
        if let name = USER?.name {
            self.userNameLabel.text = "\(name)!"
        }
        self.totalScore.makeBigCircle(self.dataSource.totalScore, progressCircleColor: #colorLiteral(red: 0.8041566014, green: 0.4145895839, blue: 0.8169354796, alpha: 1), lineWidth: 20)
        self.selfAwarenessCircleView.makeBigCircle(self.dataSource.selfAwareness, progressCircleColor: #colorLiteral(red: 1, green: 0.6533424854, blue: 0.001822904102, alpha: 1), lineWidth: 7)
        self.selfManagmentCircleView.makeBigCircle(self.dataSource.selfManagment, progressCircleColor: #colorLiteral(red: 0, green: 0.6551403403, blue: 1, alpha: 1), lineWidth: 7)
        self.relationshipManagementCircleView.makeBigCircle(self.dataSource.relationshipManagement, progressCircleColor:#colorLiteral(red: 0.5173546076, green: 1, blue: 0.9461879134, alpha: 1) , lineWidth: 7)
        self.socialAwarenessCircleView.makeBigCircle(self.dataSource.socialAwareness, progressCircleColor: #colorLiteral(red: 0.1808759272, green: 0.8263129592, blue: 0.2538549304, alpha: 1), lineWidth: 7)
        
        self.averageTotalScoreLabel.incrementLabel(to: self.dataSource.totalScore)
        self.selfAwaeenessLabel.incrementLabel(to: self.dataSource.selfAwareness)
        self.selfManagementLabel.incrementLabel(to: self.dataSource.selfManagment)
        self.socialAwarenessLabel.incrementLabel(to: self.dataSource.socialAwareness)
        self.relationshipManagementLabel.incrementLabel(to: self.dataSource.relationshipManagement)
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: "Check areas for improvement recommended by Flourish App", attributes: [NSAttributedString.Key.font:UIFont(name: "Ubuntu-Bold", size:  15)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.1890725791, green: 0.1877885163, blue: 0.426528573, alpha: 1), range: NSRange(location:0,length: 40))
        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: "Ubuntu-Medium", size:  15)!], range: NSRange(location:0,length: 40))
        self.checkAreasLabel.attributedText = myMutableString
        
        self.homeButton.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.homeButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        
        self.checkAreasView.layer.cornerRadius = 12
        self.checkAreasView.layer.borderColor = #colorLiteral(red: 0.1890725791, green: 0.1877885163, blue: 0.426528573, alpha: 1)
        self.checkAreasView.layer.borderWidth = 1
        
        self.chooseAreas.layer.cornerRadius = 12
        self.chooseAreas.layer.borderColor = #colorLiteral(red: 0.1890725791, green: 0.1877885163, blue: 0.426528573, alpha: 1)
        self.chooseAreas.layer.borderWidth = 1
        
        self.scoreByCategoriesView.layer.cornerRadius = 18
        self.scoreByCategoriesView.layer.borderColor = #colorLiteral(red: 0.8508961797, green: 0.8510394692, blue: 0.850877285, alpha: 1)
        self.scoreByCategoriesView.layer.borderWidth = 1
    }
    @IBAction func selfAwarenessButtonPresse(_ sender: Any) {
        guard let id = self.dataSource.tesResult?.selfAwarenes.selfAwarenessID else {return }
        self.dataSource.getSingleCategory(categoryID: id, categoryColor: #colorLiteral(red: 1, green: 0.6533424854, blue: 0.001822904102, alpha: 1))
    }
    @IBAction func selfManagementButtonPressed(_ sender: Any) {
        guard let id = self.dataSource.tesResult?.selfManagement.selfManagementID else {return }
        self.dataSource.getSingleCategory(categoryID: id, categoryColor: #colorLiteral(red: 0, green: 0.6551403403, blue: 1, alpha: 1))
    }
    @IBAction func socialAwarenessButtonPressed(_ sender: Any) {
        guard let id = self.dataSource.tesResult?.socialAwareness.socialAwarenessID else {return }
        self.dataSource.getSingleCategory(categoryID: id, categoryColor: #colorLiteral(red: 0.1808759272, green: 0.8263129592, blue: 0.2538549304, alpha: 1))
    }
    @IBAction func relationshipManagementButtonPressed(_ sender: Any) {
        guard let id = self.dataSource.tesResult?.relationshipManagement.relationshipManagementID else {return }
        self.dataSource.getSingleCategory(categoryID: id, categoryColor: #colorLiteral(red: 0.5173546076, green: 1, blue: 0.9461879134, alpha: 1))
    }
    @IBAction func homeButtonPressed(_ sender: Any) {
        self.delegate?.showHome()
    }
}//class

//MARK: QuizzResultVCDataSourceFeedBack
extension QuizzResultViewController: QuizzResultVCDataSourceFeedBack{
    func showSingleCategory(_ data: SingleResult, categoryColor: UIColor) {
        self.delegate?.showSingleCategory(data, categoryColor: categoryColor)
    }
    
    func dataUpdate() {
        self.setView()
    }
}

