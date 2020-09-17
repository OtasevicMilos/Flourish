//
//  DialogueMaestroCongratulationViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol DialogueMaestroCongratulationViewControllerDelegate{
    func finishDialogueMaestro()
}

class DialogueMaestroCongratulationViewController: UIViewController {
    let dataSource: DialogueMaestroCongratulationVCDataSource
    var delegate: DialogueMaestroCongratulationViewControllerDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scorePointsLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var homeButtonView: UIView!
    @IBOutlet var roundShadowViwes: [UIView]!
    @IBOutlet weak var userImageView: UIView!
    @IBOutlet weak var progressBackgroundView: UIView!
    
    init(dataSource: DialogueMaestroCongratulationVCDataSource){
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init") }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.feedback = self
        self.dataSource.getResult()
        self.setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.homeButtonView.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.homeButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
    }
    
    private func setView(){
        self.makeLine()
        if let user = USER{
            self.nameLabel.text = "\(user.name)!"
        }
        self.roundShadowViwes.forEach { view in
            view.layer.cornerRadius = view.bounds.height / 2
            view.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            view.layer.shadowRadius = 2
            view.layer.shadowOpacity = 2

        }
    }

    private func makeLine(){
        let path = UIBezierPath()
        let startPonint = CGPoint(x: 0, y: 0)
        let midPoint = CGPoint(x: self.lineView.bounds.width / 2, y: 0)
        let endPoint = CGPoint(x: self.lineView.bounds.width, y: 0)

        path.move(to: startPonint)
        path.addLine(to: CGPoint(x: midPoint.x - 7, y: midPoint.y))
        path.addLine(to: CGPoint(x: midPoint.x, y: midPoint.y + 7))
        path.addLine(to: CGPoint(x: midPoint.x + 7, y: midPoint.y))
        path.addLine(to: endPoint)
        
        let layer = CAShapeLayer()
        
        layer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        layer.path = path.cgPath
        self.lineView.layer.addSublayer(layer)
        
    }
    
    private func updateResult(){
        guard let result = self.dataSource.result else{ return}
        self.scorePointsLabel.text = "\(result)"
        guard let percent = self.dataSource.procent else{ return}
        self.percentageLabel.text = "Your score is better than \(percent)% of users"
        let distance = Double(self.progressBackgroundView.bounds.width) * (percent / 100)
        print(distance)
        print(self.userImageView.frame.origin.x + CGFloat(distance))
        // TODO: ANIMIRATI PROGRES
    }
    @IBAction func homeButtonPressed(_ sender: Any) {
        self.delegate?.finishDialogueMaestro()
    }
    
}//class

//MARK: DialogueMaestroCongratulationVCDataSource
extension DialogueMaestroCongratulationViewController :DialogueMaestroCongratulationVCDataSourceFeedback{
    func updateData() {
        self.updateResult()
    }
}
