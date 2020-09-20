//
//  DialogueMaestroViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol DialogueMaestroViewControllerDelegate{
    func startGame(questions: [Question])
    func endGame()
}

class DialogueMaestroViewController: UIViewController {
    let dataSource: DialogueMaestroVCDataSource
    var delegate: DialogueMaestroViewControllerDelegate?
    @IBOutlet var roundViews: [UIView]!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var whyDescriptionLabel: UILabel!
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionDescriptionLabel: UILabel!
    @IBOutlet weak var rulsDescription: UILabel!
    @IBOutlet weak var startButtonView: UIView!
    var questions: [Question]?
    
    init(dataSource: DialogueMaestroVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.dataSource.getHomeInformation { [weak self] response in
            switch response{
            case .success(let data):
                self?.questions = data.questions
                self?.setData(data)
            case .error:
                print("PRIKAZZTI GRESKU")
            }
        }
    }
    
   override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        self.startButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
    }
    
    private func setView(){
        self.startButtonView.clipsToBounds = true
        self.roundViews.forEach { view in
            view.clipsToBounds = true
            view.layer.cornerRadius = 21
        }
    }
    
    private func setData(_ data: DialogueMaster){
        self.timeLabel.text = "\(data.timeLimit)s "
        self.whyDescriptionLabel.text = data.translations[0].whyText
        self.goalDescriptionLabel.text = data.translations[0].goalText
        self.descriptionDescriptionLabel.text = data.translations[0].gameDescription
        self.rulsDescription.text = data.translations[0].rules
        self.questionLabel.text = "\(data.questions.count) questions"

    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        guard let questions = self.questions else { return }
        self.delegate?.startGame(questions: questions)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.delegate?.endGame()
    }
}//class
