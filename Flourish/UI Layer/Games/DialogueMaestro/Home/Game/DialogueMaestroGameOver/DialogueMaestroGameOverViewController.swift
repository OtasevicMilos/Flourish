//
//  DialogueMaestroGameOverViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol DialogueMaestroGameOverViewControllerDelegate{
    func tryAgain()
    func finishGame()
}

class DialogueMaestroGameOverViewController: UIViewController {
    var delegate: DialogueMaestroGameOverViewControllerDelegate?
    @IBOutlet weak var tryAgainButtonView: UIView!
    @IBOutlet weak var learnNowButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tryAgainButtonView.setFlourishGradien(withColors: [#colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor])
        self.tryAgainButtonView.roundCorners([.bottomLeft, .topRight], radius: 20)
        self.learnNowButtonView.layer.cornerRadius = 10
        self.learnNowButtonView.layer.borderColor = #colorLiteral(red: 0.1890725791, green: 0.1877885163, blue: 0.426528573, alpha: 1)
        self.learnNowButtonView.layer.borderWidth = 1
    }
    
    @IBAction func tryAgainButtonPressed(_ sender: Any) {
        self.delegate?.tryAgain()
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        self.delegate?.finishGame()
    }
}//class
