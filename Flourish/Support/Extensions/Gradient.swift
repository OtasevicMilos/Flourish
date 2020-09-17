//
//  Gradient.swift
//  Flourish
//
//  Created by Milos Otasevic on 08/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

extension UIView {
    
    func setFlourishGradien(_ withOutRadius: Bool = false, withColors colors: [CGColor] = [ #colorLiteral(red: 0.5568627451, green: 0.9137254902, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.7764705882, green: 0.4352941176, blue: 0.8941176471, alpha: 1).cgColor, #colorLiteral(red: 0.9607843137, green: 0.3098039216, blue: 0.3529411765, alpha: 1).cgColor],start startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5),end endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)){
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = self.bounds
        if !withOutRadius{
        gradient.cornerRadius = self.layer.cornerRadius
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}
