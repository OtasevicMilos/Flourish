//
//  Score.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct Score: Codable {
    let profileImage, totalScore: String
    let categories: [Category]
    let games: [Game]

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case totalScore
        case categories
        case games
    }
}
