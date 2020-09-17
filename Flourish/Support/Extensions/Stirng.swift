//
//  Stirng.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

extension String{
    func checkEmail() -> Bool{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: self)
    }

    func checkPhoneNumber() -> Bool {
           if self.count < 1 { return true }
           guard let number = Int(self.replacingOccurrences(of: "+", with: "")) else { return false}
           if self.count < 9 { return false }
           return true
       }

}
