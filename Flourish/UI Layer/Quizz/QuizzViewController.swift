//
//  QuizzViewController.swift
//  Flourish
//
//  Created by Janko on 04/08/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

protocol QuizzViewControllerDelegate {
    func showResults()
    func exitQuizz()
}


class QuizzViewController: UIViewController {
    let dataSource: QuizzVCDataSource
    var delegate: QuizzViewControllerDelegate?
    var currentQuestion=0
    var newCoord:CGPoint=CGPoint(x: 0, y: 0)
    
    @IBOutlet var recognizerView: UIView!
    @IBOutlet var answerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var notificationViewTC: NSLayoutConstraint!
    @IBOutlet var notificationViewTRC: NSLayoutConstraint!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var nextButtonBC: NSLayoutConstraint!
    @IBOutlet var quizzCollectionView: UICollectionView!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var numberViews: [UIView]!
    
    var answers = [Int]()
    var curentAnswer = 0
    
    init(dataSource: QuizzVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.feedback = self
        recognizerView.clipsToBounds = false
        let panGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        panGestureRecognizer.minimumPressDuration = 0.0
        answerView.addGestureRecognizer(panGestureRecognizer)
        answerView.clipsToBounds=false
        
        quizzCollectionView.register(UINib(nibName:"QuizzViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "quizzCell")
        quizzCollectionView.dataSource = self.dataSource
        quizzCollectionView.delegate = self
        drawArch()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.setFlourishGradien(withColors: [#colorLiteral(red: 0.9987233281, green: 0.835398972, blue: 0.3865250945, alpha: 1), #colorLiteral(red: 0.9942321181, green: 0.8947016597, blue: 0.6533489227, alpha: 1), #colorLiteral(red: 0.9463223815, green: 0.8453899622, blue: 0.9437918067, alpha: 1), #colorLiteral(red: 0.8822284341, green: 0.3810956478, blue: 0.5851709247, alpha: 1)], start: CGPoint(x: 0, y: 0), end: CGPoint(x: 1, y: 1))
        
        let size = CGSize(width: 256, height: 256)                                  
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.answers.append(curentAnswer)
        if currentQuestion < (self.dataSource.quizz.questions.count - 1) {
            currentQuestion += 1
            
            quizzCollectionView.scrollToItem(at: IndexPath(row: currentQuestion, section: 0), at: .centeredHorizontally, animated: true)
            currentQuestionLabel.text = "\(currentQuestion + 1)"
            UIView.animate(withDuration: 1, animations: {
                self.answerView.frame=CGRect(x: 138, y: 106, width: 74, height: 74)
                self.nextButtonBC.constant = -100
                self.notificationViewTC.constant = 15
                self.notificationViewTRC.constant = 5
                self.view.layoutIfNeeded()
            })
        }else{
            self.dataSource.finishTest(answers: self.answers)
        }
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer){
        if recognizer.view==nil{
            return
        }
        if recognizer.state==UIGestureRecognizer.State.began{
            
        }
        self.newCoord=recognizer.location(in: recognizerView)
        let x = self.newCoord.x-(recognizer.view?.frame.width ?? 0)/2
        let y = self.newCoord.y-(recognizer.view?.frame.height ?? 0)/2
        if x < -35 || x>305 || y <= -35 || y>150{
            UIView.animate(withDuration: 0.4, animations: {
                self.answerView.frame=CGRect(x: 138, y: 106, width: 74, height: 74)
                self.nextButtonBC.constant = -100
                self.notificationViewTC.constant = 15
                self.notificationViewTRC.constant = 5
                self.view.layoutIfNeeded()
            })
            return
        }
        answerView.frame=CGRect(x: x, y: y, width: 74, height: 74)
        recognizerView.bringSubviewToFront(answerView)
        if recognizer.state==UIGestureRecognizer.State.ended{
            dragAnswerView(x: x, y: y)
        }
        print(x,y)
        
    }
    func dragAnswerView(x:CGFloat,y:CGFloat){
        var center=false
        //center
        if x>102 && x<176 && y<70{
            UIView.animate(withDuration: 0.7, animations: {
                self.answerView.frame=CGRect(x: 138, y: 2, width: 74, height: 74)
                self.view.layoutIfNeeded()
            })
            notificationLabel.text="3"
            self.curentAnswer = 3
        }else if x > -35 && x<100 && y<70{
            UIView.animate(withDuration: 0.7, animations: {
                self.answerView.frame=CGRect(x: 49.5, y: 21.5, width: 74, height: 74)
                self.view.layoutIfNeeded()
            })
            notificationLabel.text="2"
            self.curentAnswer = 2
        }else if x > 175 && x<300 && y<70{
            UIView.animate(withDuration: 0.7, animations: {
                self.answerView.frame=CGRect(x: 227, y: 21.5, width: 74, height: 74)
                self.view.layoutIfNeeded()
            })
            notificationLabel.text="4"
            self.curentAnswer = 4
        }else if x < 103{
            UIView.animate(withDuration: 0.7, animations: {
                self.answerView.frame=CGRect(x: 3, y: 110.5, width: 74, height: 74)
                self.view.layoutIfNeeded()
            })
            notificationLabel.text="1"
            self.curentAnswer = 1
        }else if x > 175{
            UIView.animate(withDuration: 0.7, animations: {
                self.answerView.frame=CGRect(x: 272.5, y: 110.5, width: 74, height: 74)
                self.view.layoutIfNeeded()
                
            })
            notificationLabel.text="5"
            self.curentAnswer = 5
        }else{
            UIView.animate(withDuration: 0.7, animations: {
                self.answerView.frame=CGRect(x: 138, y: 106, width: 74, height: 74)
                self.nextButtonBC.constant = -100
                self.notificationViewTC.constant = 15
                self.notificationViewTRC.constant = 5
                self.view.layoutIfNeeded()
            })
            center=true
        }
        if !center{
            UIView.animate(withDuration: 0.7, animations: {
                self.notificationViewTC.constant = -15
                self.notificationViewTRC.constant = -5
                self.nextButtonBC.constant=0
                self.view.layoutIfNeeded()
            })
        }
        recognizerView.bringSubviewToFront(answerView)
    }
    func drawArch(){
        createShortLine(color: #colorLiteral(red: 0.8898188472, green: 0.8014473319, blue: 0.8829014897, alpha: 1), start: numberViews[0].center, end: numberViews[1].center)
        createShortLine(color: #colorLiteral(red: 0.886182785, green: 0.7775782943, blue: 0.9015724063, alpha: 1), start: numberViews[1].center, end: numberViews[2].center)
        createShortLine(color: #colorLiteral(red: 0.8862336278, green: 0.7844361663, blue: 0.8977819681, alpha: 1), start: numberViews[2].center, end: numberViews[3].center)
        createShortLine(color: #colorLiteral(red: 0.8928123116, green: 0.7205656171, blue: 0.8531989455, alpha: 1), start: numberViews[3].center, end: numberViews[4].center)

    }
    
    private func createShortLine(color: UIColor,start: CGPoint, end: CGPoint){
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        recognizerView.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.delegate?.exitQuizz()
    }
}//class

//MARK: UICollectionViewDelegate
extension QuizzViewController: UICollectionViewDelegate{
}

//MARK: UICollectionViewDelegateFlowLayout
extension QuizzViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: quizzCollectionView.bounds.width, height: quizzCollectionView.bounds.height)
        
    }
}

//MARK: QuizzVCDataSourceFeedback
extension QuizzViewController: QuizzVCDataSourceFeedback{
    func showResult() {
        self.delegate?.showResults()
    }
}
