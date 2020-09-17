//
//  PresenterViewController.swift
//  Flourish
//
//  Created by Milos Otasevic on 09/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

protocol PresenterViewControllerDelegare{
    func showMyProgressVC()
    func showGamesVC()
    func showPreferencesVC()
}
class PresenterViewController: UIViewController {
    var delegate: PresenterViewControllerDelegare?
    var vcToPressent: UIViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var customTabBar: UIView!
    @IBOutlet weak var myProgressLabel: UILabel!
    @IBOutlet weak var myProgressInticatorView: UIView!
    @IBOutlet weak var preferencesLable: UILabel!
    @IBOutlet weak var preferencesIndicatorView: UIView!
    @IBOutlet weak var gameButtonView: UIView!
    @IBOutlet var frontComponents: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.present(vcToPressent)
    }
    
    func present(_ vc: UIViewController?){
        guard let vc = vc else {return }
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        containerView.bringSubviewToFront(vc.view)
        vc.didMove(toParent: self)
        self.frontComponents.forEach { view in
            self.containerView.bringSubviewToFront(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.createTabBarPath()
    }
    
    private func setView(){
        self.myProgressInticatorView.setFlourishGradien(start: CGPoint(x: -0.3, y: 0.5))
        self.preferencesIndicatorView.setFlourishGradien(start: CGPoint(x: -0.3, y: 0.5))
        self.preferencesIndicatorView.isHidden = true
        self.gameButtonView.setFlourishGradien(start: CGPoint(x: 0, y: 1), end: CGPoint(x: 1, y: 0))
    }
    
    private func createTabBarPath(){
        let path = UIBezierPath()
        let with = UIScreen.main.bounds.width
        let distanceBetwenButtons = 80
        let startPosition = CGPoint(x: 0, y: 0)
        let topMidPosition = CGPoint(x: with / 2, y: 0)
        
        let controlMidPoint1 = CGPoint(x: with / 2 - 35, y: self.customTabBar.bounds.height * 0.85)
        let controlMidPoint2 = CGPoint(x: with / 2 + 35, y: self.customTabBar.bounds.height * 0.85)
        
        let topEndPoind = CGPoint(x: with, y: 0 )
        let downEndPoind = CGPoint(x: with, y: self.customTabBar.bounds.height )
        
        path.move(to: startPosition)
        
        path.addLine(to: CGPoint(x: topMidPosition.x - CGFloat(distanceBetwenButtons / 2), y: topMidPosition.y))
        path.addCurve(to: CGPoint(x: topMidPosition.x + CGFloat(distanceBetwenButtons / 2), y: topMidPosition.y), controlPoint1: controlMidPoint1, controlPoint2: controlMidPoint2)
        path.addLine(to: topEndPoind)
        path.addLine(to: downEndPoind)
        path.addLine(to: CGPoint(x: 0, y: self.customTabBar.bounds.height))
        path.close()
        
        let layer = CAShapeLayer()
        
        layer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.path = path.cgPath
        self.customTabBar.layer.addSublayer(layer)
    }
    
    @IBAction func myProgressButtonPressed(_ sender: Any) {
        self.myProgressInticatorView.isHidden = false
        self.preferencesIndicatorView.isHidden = true
        self.myProgressLabel.textColor = #colorLiteral(red: 0.8039215686, green: 0.4156862745, blue: 0.8156862745, alpha: 1)
        self.preferencesLable.textColor = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6862745098, alpha: 1)
        self.delegate?.showMyProgressVC()
    }
    @IBAction func gameButtonPressed(_ sender: Any) {
        self.delegate?.showGamesVC()
    }
    @IBAction func vButtonPressed(_ sender: Any) {
        self.delegate?.showPreferencesVC()
        self.myProgressInticatorView.isHidden = true
        self.preferencesIndicatorView.isHidden = false
        self.myProgressLabel.textColor = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6862745098, alpha: 1)
        self.preferencesLable.textColor = #colorLiteral(red: 0.8039215686, green: 0.4156862745, blue: 0.8156862745, alpha: 1)
    }
}
