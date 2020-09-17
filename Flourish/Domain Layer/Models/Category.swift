//
//  Category.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let userResults: [UserResult]

    enum CodingKeys: String, CodingKey {
        case id
        case userResults = "user_results"
    }
}

