//
//  QuizzInfoViewController.swift
//  Flourish
//
//  Created by Janko on 04/08/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

protocol QuizzInfoViewControllerDelegate{
    func takeTest(quizz: Quizz)
}

class QuizzInfoViewController: UIViewController {
    let dataSource: QuizzInfoVCDataSource
    var delegate: QuizzInfoViewControllerDelegate?
    @IBOutlet var gradinetView: UIView!
    @IBOutlet var testButton: UIButton!
    @IBOutlet var questionsView: UIView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var downView: UIView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    init(dataSource: QuizzInfoVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {  fatalError("init")}
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
        self.testButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.downView.roundCorners([.topLeft, .topRight], radius: 20)

      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.getQuizz()
        self.dataSource.feedback = self
        self.setView()
    }
    
    private func setView(){
        self.gradinetView.setFlourishGradien(withColors: [#colorLiteral(red: 0.9939696193, green: 0.8103442192, blue: 0.433010757, alpha: 1).cgColor, #colorLiteral(red: 0.8922502398, green: 0.5968217254, blue: 0.705218792, alpha: 1).cgColor,  #colorLiteral(red: 0.5129089952, green: 0.3381103277, blue: 0.5956622958, alpha: 1).cgColor], start: CGPoint(x: 0.2, y: 0), end: CGPoint(x: 0.5, y: 1))
        self.testButton.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.testButton.clipsToBounds = true
        self.questionsView.layer.cornerRadius = 10
        self.questionsView.clipsToBounds = true
        self.timeView.layer.cornerRadius = 10
        self.timeView.clipsToBounds = true
    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
        guard let quizz = self.dataSource.quizz else {return}
        self.delegate?.takeTest(quizz: quizz)
    }
    
    
}//class

//MARK: QuizzInfoVCDataSourceFeedBack
extension QuizzInfoViewController: QuizzVCDataSourceFeedBack{
    
    func updateData() {
        guard let guizz = self.dataSource.quizz  else {return}
        self.questionLabel.text = "\(guizz.questions.count) questions"
        self.timeLabel.text = "\(guizz.time) minutes"
    }
    
}
