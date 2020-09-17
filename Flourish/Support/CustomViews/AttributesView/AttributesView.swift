//
//  AttributesView.swift
//  Flourish
//
//  Created by Janko on 01/08/2020.
//  Copyright © 2020 Janko. All rights reserved.
//

import UIKit

class AttributesView: UIView {
    
    var coordinateXLeft:CGFloat!
    var coordinateYTop:CGFloat!
    var coordinateXRight:CGFloat!
    var coordinateYBottom:CGFloat!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var contentBoundsView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("AttributesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame=self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.clipsToBounds=false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    func presentAttributesViewShapeLayer(socialAwareness: Double, selfAwareness: Double, selfMangement: Double, relationshipManagment: Double){
        coordinateXLeft = (contentBoundsView.frame.size.width / 2) * (CGFloat(100 - selfAwareness) / 100)
        coordinateYTop = contentBoundsView.frame.height / 2 *  (CGFloat(100 - socialAwareness) / 100)
        coordinateXRight = contentBoundsView.frame.size.width / 2 + (contentBoundsView.frame.size.width / 2 * (CGFloat( selfMangement) / 100))
        coordinateYBottom = contentBoundsView.frame.size.height / 2 + (contentBoundsView.frame.size.height / 2 * (CGFloat(relationshipManagment) / 100))
        addHorizontalLine()
        addVerticalLine()
        addOutsideSquare()
        addInsideSquare()
        addAttributesSquare()
    }
    
    func addHorizontalLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0 , y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width, y: self.contentBoundsView.frame.size.height/2))
        path.close()
        contentBoundsView.layer.addSublayer(customCAShapeLayer(path: path))
    }
    func addVerticalLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:self.contentBoundsView.frame.size.width/2 , y: 0))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width/2, y: self.contentBoundsView.frame.size.height))
        path.close()
        contentBoundsView.layer.addSublayer(customCAShapeLayer(path: path))
    }
    func addOutsideSquare(){
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x:0 , y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width/2, y: 0))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width, y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width/2, y: self.contentBoundsView.frame.size.height))
        path.close()
        
        contentBoundsView.layer.addSublayer(customCAShapeLayer(path: path))
        
    }
    func addInsideSquare(){
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x:self.contentBoundsView.frame.size.width/4 , y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width/2, y: self.contentBoundsView.frame.size.height/4))
        path.addLine(to: CGPoint(x: (3*(self.contentBoundsView.frame.size.width/4)), y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width/2, y: (3*(self.contentBoundsView.frame.size.height/4))))
        path.close()
        contentBoundsView.layer.addSublayer(customCAShapeLayer(path: path))
    }
    func attributesSquarePath(coordinateXLeft:CGFloat,coordinateYTop:CGFloat,coordinateXRight:CGFloat,coordinateYBottom:CGFloat)->UIBezierPath{
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x:coordinateXLeft , y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x:self.contentBoundsView.frame.size.width/2, y: coordinateYTop))
        path.addLine(to: CGPoint(x: coordinateXRight, y: self.contentBoundsView.frame.size.height/2))
        path.addLine(to: CGPoint(x: self.contentBoundsView.frame.size.width/2, y: coordinateYBottom))
        path.close()
        return path
    }
    
    func addAttributesSquare(){
        let path=attributesSquarePath(coordinateXLeft: coordinateXLeft, coordinateYTop: coordinateYTop, coordinateXRight: coordinateXRight, coordinateYBottom: coordinateYBottom)
        let attributesSquareFrameView=UIView()
        attributesSquareFrameView.frame=CGRect(x: coordinateXLeft, y: coordinateYTop, width: coordinateXRight, height: coordinateYBottom)
        let attributesSquareBorder = CAShapeLayer()
        attributesSquareBorder.path=path.cgPath
        attributesSquareBorder.strokeColor = UIColor.white.cgColor
        attributesSquareBorder.lineWidth = 3.5
        attributesSquareBorder.fillColor = UIColor.clear.cgColor
        attributesSquareBorder.strokeEnd = 2
        
        contentBoundsView.addSubview(attributesSquareFrameView)
        
        let gradientMask = CAShapeLayer()
        gradientMask.frame = contentBoundsView.bounds
        gradientMask.path = path.cgPath
        
        let gradientLayer:CAGradientLayer=radiateGradientLayer()
        gradientLayer.frame = attributesSquareFrameView.bounds
        gradientLayer.mask = gradientMask
        contentBoundsView.layer.addSublayer(gradientLayer)
        contentBoundsView.layer.addSublayer(attributesSquareBorder)
        
    }
    
    func customCAShapeLayer(path:UIBezierPath)->CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path=path.cgPath
        //   horizontalLine.strokeColor = UIColor(red: 80/255, green: 82/255, blue: 83/255, alpha: 0.1).cgColor
        shapeLayer.strokeColor=UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        return shapeLayer
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
