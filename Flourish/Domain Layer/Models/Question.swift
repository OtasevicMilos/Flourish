//
//  Question.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct Question: Codable {
    let id, gameID, categoryID: Int
    let translations: [QuestionTranslation]
    let answers: [Answer]

    enum CodingKeys: String, CodingKey {
        case id
        case gameID = "game_id"
        case categoryID = "category_id"
        case translations, answers
    }
}

struct QuestionTranslation: Codable {
    let id, languageID, questionID: Int
    let question: String

    enum CodingKeys: String, CodingKey {
        case id
        case languageID = "language_id"
        case questionID = "question_id"
        case question
    }
}
