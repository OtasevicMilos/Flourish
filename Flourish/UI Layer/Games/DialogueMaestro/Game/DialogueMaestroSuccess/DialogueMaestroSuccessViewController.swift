//
//  DialogueMaestroSuccessViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class DialogueMaestroSuccessViewController: UIViewController {
    let answer: Answer
    var feedback: DialogueMaestroAnswerFeedback?
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nextQuestionButton: UIView!
    @IBOutlet weak var yourAnswerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init(answer: Answer){
        self.answer = answer
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init") }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setView()
    }
    
    private func setView(){
        self.nextQuestionButton.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.nextQuestionButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.topView.roundCorners([.topLeft, .topRight], radius: 20)
        self.topView.clipsToBounds = true
        self.yourAnswerLabel.text = answer.translations[0].answerBody
        self.descriptionLabel.text = answer.answerDescription.translations[0].translationDescription
    }
    @IBAction func nextQuestionButtonPressed(_ sender: Any) {
        self.feedback?.startTimer()
        self.dismiss(animated: true, completion: nil)
    }
}//class
