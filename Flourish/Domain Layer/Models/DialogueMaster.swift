//
//  DialogueMaster.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct DialogueMaster: Codable{
    let id: Int
    let categoryID: Int
    let timeLimit: Int
    let scoreLimit: Int
    let gameImage: String
    let createdAt: String
    let updatedAt: String
    let translations: [GameTranslation]
    let questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case timeLimit = "time_limit"
        case scoreLimit = "score_limit"
        case gameImage = "game_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case translations
        case questions
    }
}

struct GameTranslation: Codable {
    let id: Int
    let languageID: Int
    let gameID: Int
    let gameTitle: String
    let whyText: String
    let goalText: String
    let gameDescription: String
    let rules: String
    let scoreKpi: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case languageID = "language_id"
        case gameID = "game_id"
        case gameTitle = "game_title"
        case whyText = "why_text"
        case goalText = "goal_text"
        case gameDescription = "game_description"
        case rules
        case scoreKpi = "score_kpi"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
