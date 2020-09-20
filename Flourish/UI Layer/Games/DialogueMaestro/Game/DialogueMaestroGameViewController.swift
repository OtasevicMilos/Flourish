//
//  DialogueMaestroGameViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol DialogueMaestroAnswerFeedback{
    func startTimer()
}

protocol DialogueMaestroGameViewControllerDelegate{
    func gameOver()
    func gameFinish(points: [Int])
}

class DialogueMaestroGameViewController: UIViewController {
    var delegate: DialogueMaestroGameViewControllerDelegate?
    let questions: [Question]
    var points = [Int]()
    var level = 0
    var lifes = 3
    var time = 60
    var timerActive = true
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var life3Image: UIImageView!
    @IBOutlet weak var life2Imafge: UIImageView!
    @IBOutlet weak var life1Image: UIImageView!
    @IBOutlet weak var guestionLabel: UILabel!
    @IBOutlet var answers: [UILabel]!
    @IBOutlet var answersViews: [UIView]!
    
    
    init(questions: [Question]){
        self.questions = questions
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {  fatalError("init")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.setlevel()
        timer()
    }
    
    private func setView(){
        self.levelView.layer.cornerRadius = 15
        self.levelView.clipsToBounds = true
        self.levelLabel.text = "1/\(self.questions.count)"
        self.answersViews.forEach { view in
            view.layer.cornerRadius = 12
            view.clipsToBounds = true
        }
    }
    private func setlevel(){
        if level == self.questions.count{
            self.delegate?.gameFinish(points: points)
            return
        }
        self.levelLabel.text = "\(level + 1)/\(self.questions.count)"
        self.guestionLabel.text = self.questions[level].translations[0].question
        for i in 0..<self.answers.count{
            self.answers[i].text = self.questions[level].answers[i].translations[0].answerBody
        }
    }
    var timerSeconds = Timer()
    
    private func timer(){
        timerSeconds = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "startCount", userInfo: nil, repeats: true)
    }
    
    @objc func startCount(){
        if !timerActive {return}
        self.time -= 1
        self.timeLabel.text = "\(time)s "
        if self.time == 0{ self.timeEnd()}
    }
    
    private func timeEnd(){
        self.level += 1
        self.time = 60
        self.lifes -= 1
        self.points.append(0)
        self.setlevel()
        
        switch self.lifes {
        case 2:
            self.life1Image.image = UIImage(named: "noLife")
        case 1:
            self.life2Imafge.image = UIImage(named: "noLife")
        default:
            self.delegate?.gameOver()
        }
    }
    
    private func showAnswer(_ answer: Answer){
        self.level += 1
        self.time = 60
        if answer.isCorrect == 1{
            let dialogueMaestroSuccessVC = DialogueMaestroSuccessViewController(answer: answer)
            dialogueMaestroSuccessVC.feedback = self
            self.present(dialogueMaestroSuccessVC, animated: true, completion: nil)
            let reuslt = 500/(61 - self.time)
            self.points.append(reuslt)
            self.setlevel()
            return
        }
        self.lifes -= 1
        self.points.append(0)
        self.setlevel()

        switch self.lifes {
        case 2:
            self.life1Image.image = UIImage(named: "noLife")
        case 1:
            self.life2Imafge.image = UIImage(named: "noLife")
        default:
            self.delegate?.gameOver()
        }
        let dialogueMaestroFailVC = DialogueMaestroFailViewController(answer: answer)
        dialogueMaestroFailVC.feedback = self
        self.present(dialogueMaestroFailVC, animated: true, completion: nil)
    }
    
    @IBAction func answer1ButtonPressed(_ sender: Any) {
        self.timerActive = false
        self.showAnswer(self.questions[level].answers[0])
    }
    @IBAction func answer2ButtonPressed(_ sender: Any) {
        self.timerActive = false
        self.showAnswer(self.questions[level].answers[1])
    }
    @IBAction func answer3ButtonPressed(_ sender: Any) {
        self.timerActive = false
        self.showAnswer(self.questions[level].answers[2])
    }
    @IBAction func answer4ButtonPressed(_ sender: Any) {
        self.timerActive = false
        self.showAnswer(self.questions[level].answers[3])
    }
}//class

//MARK: DialogueMaestroAnswerFeedback
extension DialogueMaestroGameViewController: DialogueMaestroAnswerFeedback{
    func startTimer() {
        self.timerActive = true
    }
}
