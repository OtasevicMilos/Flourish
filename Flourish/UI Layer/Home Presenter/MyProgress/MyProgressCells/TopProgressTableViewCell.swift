//
//  TopProgressTableViewCell.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

class TopProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var attributesView: AttributesView!
    @IBOutlet weak var selfAwarenessLable: UILabel!
    @IBOutlet weak var selfMangement: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var test: GraphView!

    @IBOutlet weak var selfAwarenessValueLabel: UILabel!
    @IBOutlet weak var selfmanagmentValueLabel: UILabel!
    @IBOutlet weak var socialAwarnessValueLabel: UILabel!
    @IBOutlet weak var relationshipManagmentValueLabel: UILabel!
    @IBOutlet weak var improveYourScoreLable: GradientLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setAttributesView(socialAwareness: Double, selfAwareness: Double, selfMangement: Double, relationshipManagment: Double){
        self.socialAwarnessValueLabel.text = "\(socialAwareness)"
        self.selfAwarenessValueLabel.text = "\(selfAwareness)"
        self.selfmanagmentValueLabel.text = "\(selfMangement)"
        self.relationshipManagmentValueLabel.text = "\(relationshipManagment)"
        self.test.setCustomShapeLayer(socialAwareness: socialAwareness, selfAwareness: selfAwareness, selfMangement: selfMangement, relationshipManagment: relationshipManagment)
    }
    
    private func setView(){
        self.userImage.layer.cornerRadius = self.userImage.bounds.width / 2
        self.userImage.clipsToBounds = true
        self.gradientView.layer.cornerRadius = 10
        self.gradientView.clipsToBounds = true
        self.gradientView.setFlourishGradien(withColors: [ #colorLiteral(red: 0.7176470588, green: 0.5647058824, blue: 0.9215686275, alpha: 1).cgColor, #colorLiteral(red: 0.8941176471, green: 0.3568627451, blue: 0.5529411765, alpha: 1).cgColor],start: CGPoint(x: 0, y: 1), end: CGPoint(x: 1, y: 0))
        self.selfAwarenessLable.transform = CGAffineTransform( rotationAngle: .pi / -2 )
        self.selfMangement.transform = CGAffineTransform( rotationAngle: .pi / -2 )
        
        self.improveYourScoreLable.gradientColors = [ #colorLiteral(red: 0.7176470588, green: 0.5647058824, blue: 0.9215686275, alpha: 1).cgColor, #colorLiteral(red: 0.8941176471, green: 0.3568627451, blue: 0.5529411765, alpha: 1).cgColor]
    }
}//class

class GraphView: UIView{
    
    func setCustomShapeLayer(socialAwareness: Double, selfAwareness: Double, selfMangement: Double, relationshipManagment: Double){
        self.setBasehapeLayer()
        let width = self.bounds.width
        let height = self.bounds.height
        
        let selfAwarenessPosition = (width / 2) * (CGFloat(100 - selfAwareness) / 100)
        let socialAwarenessPosition = height / 2 *  (CGFloat(100 - socialAwareness) / 100)
        let selfMangementPosition = width / 2 + width / 2 * (CGFloat( selfMangement) / 100)
        let relationshipManagmentPosition  = height / 2 + height / 2 * (CGFloat(relationshipManagment) / 100)
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x:selfAwarenessPosition , y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: socialAwarenessPosition))
        path.addLine(to: CGPoint(x: selfMangementPosition, y: height / 2))
        path.addLine(to: CGPoint(x:  width / 2, y: relationshipManagmentPosition))
        path.close()
        
        let attributesSquareFrameView = UIView()
        attributesSquareFrameView.frame=CGRect(x:
         selfAwarenessPosition, y: socialAwarenessPosition, width: selfMangementPosition, height: relationshipManagmentPosition)
        let attributesSquareBorder = CAShapeLayer()
        attributesSquareBorder.path=path.cgPath
        attributesSquareBorder.strokeColor = UIColor.white.cgColor
        attributesSquareBorder.lineWidth = 3.5
        attributesSquareBorder.fillColor = UIColor.clear.cgColor
        attributesSquareBorder.strokeEnd = 2
        
        self.addSubview(attributesSquareFrameView)
        
        let gradientMask = CAShapeLayer()
        gradientMask.frame = self.bounds
        gradientMask.path = path.cgPath
        
        let gradientLayer:CAGradientLayer = radiateGradientLayer()
        gradientLayer.frame = attributesSquareFrameView.bounds
        gradientLayer.mask = gradientMask
        self.layer.addSublayer(gradientLayer)
        self.layer.addSublayer(attributesSquareBorder)
        
    }
    
    func setBasehapeLayer(){
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0 , y: height/2))
        path.addLine(to: CGPoint(x: width, y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width / 2, y: height / 2))
        
        path.addLine(to: CGPoint(x:width * 0.02 , y: height/2))
        path.addLine(to: CGPoint(x: width / 2, y: height * 0.02))
        path.addLine(to: CGPoint(x: width * 0.98, y: height / 2))
        path.addLine(to: CGPoint(x: width/2, y: height * 0.98))
        path.addLine(to: CGPoint(x:width * 0.02 , y: height/2))
        path.addLine(to: CGPoint(x: width / 2, y: height / 2))

        path.addLine(to: CGPoint(x: width * 0.25 , y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height * 0.25))
        path.addLine(to: CGPoint(x: width * 0.75 , y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height * 0.75))
        path.addLine(to: CGPoint(x: width * 0.25 , y: height / 2))
        path.addLine(to: CGPoint(x: width / 2, y: height / 2))

        path.close()
        self.layer.addSublayer(acustomCAShapeLayer(path: path))
    }
    
    func acustomCAShapeLayer(path:UIBezierPath)->CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path=path.cgPath
        shapeLayer.strokeColor=UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        return shapeLayer
    }
    
    func aradiateGradientLayer()->CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.type = .radial
        
        gradient.colors = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3).cgColor,UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6).cgColor,UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor]
        gradient.locations=[0,0.5,1]
        let center = CGPoint(x: 0.55, y: 0.55)
        gradient.startPoint = center
        
        let radius = 0.98
        gradient.endPoint = CGPoint(x: radius, y: radius)
        return gradient
    }
    
    func radiateGradientLayer()->CAGradientLayer{
        let gradient = CAGradientLayer()
        // g.frame=self.bounds
        gradient.type = .radial
        
        gradient.colors = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3).cgColor,UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6).cgColor,UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor]
        gradient.locations=[0,0.5,1]
        let center = CGPoint(x: 0.55, y: 0.55)
        gradient.startPoint = center
        
        let radius = 0.98
        gradient.endPoint = CGPoint(x: radius, y: radius)
        return gradient
    }
    
}
