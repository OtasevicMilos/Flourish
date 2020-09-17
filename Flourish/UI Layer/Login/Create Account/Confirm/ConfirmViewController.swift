//
//  ConfirmViewController.swift
//  Flourish
//
//  Created by Janko on 24/07/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

protocol ConfirmViewControllerDelegate{
    func finish()
}

class ConfirmViewController: UIViewController {
    var delegate: ConfirmViewControllerDelegate?
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.roundCorners([.bottomLeft, .topRight], radius: 20)
        okButton.setFlourishGradien(start: CGPoint(x: -0.4, y: 0.5))
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: circleView.bounds.size.width/2, y: circleView.bounds.size.height/2), radius: CGFloat(circleView.bounds.size.height/2), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 0.6).cgColor
        
        circleView.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func okButton(_ sender: Any) {
            self.delegate?.finish()
    }
}
