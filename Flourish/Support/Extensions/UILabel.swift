//
//  UILabel.swift
//  Flourish
//
//  Created by Milos Otasevic on 18/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import UIKit

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
