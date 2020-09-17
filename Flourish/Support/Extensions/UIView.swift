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
}}
