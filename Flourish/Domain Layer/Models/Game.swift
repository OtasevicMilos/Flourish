//
//  Game.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct Game: Codable {
    let id: Int
    let categoryID: Int
    let timeLimit: Int
    let scoreLimit: Int
    let gameImage: String
    let createdAt: String
    let updatedAt: String
    let translations: [Translation]

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case timeLimit = "time_limit"
        case scoreLimit = "score_limit"
        case gameImage = "game_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case translations
    }
}
