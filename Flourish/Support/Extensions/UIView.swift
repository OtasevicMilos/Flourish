//
//  UIView.swift
//  Flourish
//
//  Created by Milos Otasevic on 11/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

extension UIView {
func shake(){
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
    self.layer.add(animation, forKey: "shake")
}
    
    func createBigCircleBackground(lineWidth: Int){
        let fixedCircleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:self.frame.width/2, y:self.frame.height/2),
                                      radius: self.frame.height/2-10,
                                      startAngle: 0,
                                      endAngle:2*CGFloat.pi ,
                                      clockwise: true)
        fixedCircleLayer.path=circlePath.cgPath
        fixedCircleLayer.strokeColor = UIColor(red: 80/255, green: 82/255, blue: 83/255, alpha: 0.1).cgColor
        fixedCircleLayer.lineWidth = CGFloat(lineWidth)
        fixedCircleLayer.fillColor = UIColor.clear.cgColor
        fixedCircleLayer.strokeEnd = 1
        self.layer.addSublayer(fixedCircleLayer)
        
    }
    func makeBigCircle(_ percent: Int,progressCircleColor: UIColor, lineWidth: Int){
        createBigCircleBackground(lineWidth: lineWidth)
        let bigCircleLayer = CAShapeLayer()

        let endAngle = CGFloat(3*CGFloat.pi/2) + CGFloat(0.0627*Double(percent))
        let  bigCirclePath = UIBezierPath(arcCenter: CGPoint(x:self.frame.width/2, y:self.frame.height/2),
                                          radius: self.frame.height/2-10,
                                          startAngle:3*CGFloat.pi/2,
                                          endAngle: endAngle,
                                          clockwise: true)
        bigCircleLayer.path=bigCirclePath.cgPath
        bigCircleLayer.strokeColor = progressCircleColor.cgColor
        bigCircleLayer.lineWidth =  CGFloat(lineWidth)
        bigCircleLayer.fillColor = UIColor.clear.cgColor
        bigCircleLayer.strokeEnd = 1
        bigCircleLayer.lineCap = .round
        self.layer.addSublayer(bigCircleLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 1.5
        bigCircleLayer.add(animation, forKey: "MyAnimation")
    }
}
