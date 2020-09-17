//
//  DMResult.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class DMResult: Codable {
    let result: Int
    let percent: String
    
    init(result: Int, percent: String){
        self.result = result
        self.percent = percent
    }
}
