//
//  CircleView.swift
//  Flourish
//
//  Created by Milos Otasevic on 17/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

    class CircleView: UIView{
        
        let bigCircleLayer = CAShapeLayer()
        
        @IBOutlet weak var percentLabel: UILabel!
        @IBOutlet weak var contentView: UIView!
        @IBOutlet var mainView: UIView!
        var progressCircleColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        required init?(coder: NSCoder) {
            super.init(coder:coder)
            commonInit()
        }
        private func commonInit(){
            Bundle.main.loadNibNamed("CircleView", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame=self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            contentView.clipsToBounds=false
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            mainView.layoutIfNeeded()
//            createBigCircleBackground()
        }
        func createBigCircleBackgroundd(){
            let fixedCircleLayer = CAShapeLayer()
            let circlePath = UIBezierPath(arcCenter: CGPoint(x:mainView.frame.width/2, y:mainView.frame.height/2),
                                          radius: mainView.frame.height/2-10,
                                          startAngle: 0,
                                          endAngle:2*CGFloat.pi ,
                                          clockwise: true)
            fixedCircleLayer.path=circlePath.cgPath
            fixedCircleLayer.strokeColor = UIColor(red: 80/255, green: 82/255, blue: 83/255, alpha: 0.1).cgColor
            fixedCircleLayer.lineWidth = 15
            fixedCircleLayer.fillColor = UIColor.clear.cgColor
            fixedCircleLayer.strokeEnd = 1
            mainView.layer.addSublayer(fixedCircleLayer)
            
        }
        func makeBigCircle(_ percent: Int ){
            let endAngle = CGFloat(3*CGFloat.pi/2) + CGFloat(0.0627*Double(percent))
            self.incrementLabell(to: percent)
            let  bigCirclePath = UIBezierPath(arcCenter: CGPoint(x:mainView.frame.width/2, y:mainView.frame.height/2),
                                              radius: mainView.frame.height/2-10,
                                              startAngle: 3*CGFloat.pi/2,
                                              endAngle: endAngle,
                                              clockwise: true)
            bigCircleLayer.path=bigCirclePath.cgPath
            bigCircleLayer.strokeColor = self.progressCircleColor.cgColor
            bigCircleLayer.lineWidth = 20
            bigCircleLayer.fillColor = UIColor.clear.cgColor
            bigCircleLayer.strokeEnd = 1
            bigCircleLayer.lineCap = .round
            mainView.layer.addSublayer(bigCircleLayer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 1.5
            bigCircleLayer.add(animation, forKey: "MyAnimation")
            
        }
        
        func incrementLabell(to endValue: Int) {
            let duration: Double = 1.5
            if endValue == 0 {
                self.percentLabel.text = "0"
                return
            }else if endValue == 1{
                self.percentLabel.text = "1"
                return
            }
            DispatchQueue.global().async {
                for i in 0 ..< (endValue + 1) {
                    if (i % 2 == 0 || i == endValue){
                        let sleepTime = UInt32(duration/Double(endValue / 2) * 1000000.0)
                        usleep(sleepTime)
                        DispatchQueue.main.async {
                            self.percentLabel.text = "\(i)"
                        }
                    }
                }
            }
        }
        
    }

extension UIView{
    
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

extension UILabel{
    func incrementLabel(to endValue: Int) {
        let duration: Double = 1.5
        if endValue == 0 {
            self.text = "0"
            return
        }else if endValue == 1{
            self.text = "1"
            return
        }
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                if (i % 2 == 0 || i == endValue){
                    let sleepTime = UInt32(duration/Double(endValue / 2) * 1000000.0)
                    usleep(sleepTime)
                    DispatchQueue.main.async {
                        self.text = "\(i)"
                    }
                }
            }
        }
    }
}
