//
//  Answer.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct Answer: Codable {
    let id, questionID, descriptionID, isCorrect: Int
    let translations: [AnswerTranslation]
    let answerDescription: AnswerDescription

    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question_id"
        case descriptionID = "description_id"
        case isCorrect = "is_correct"
        case translations
        case answerDescription = "description"
    }
}

struct AnswerTranslation: Codable {
    let id, languageID, answerID: Int
    let answerBody: String

    enum CodingKeys: String, CodingKey {
        case id
        case languageID = "language_id"
        case answerID = "answer_id"
        case answerBody = "answer_body"
    }
}

struct AnswerDescription: Codable {
    let id: Int
    let translations: [DescriptionTranslation]
    enum CodingKeys: String, CodingKey {
        case id
        case translations
    }
}

struct DescriptionTranslation: Codable {
    let id, languageID, descriptionID: Int
    let translationDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case languageID = "language_id"
        case descriptionID = "description_id"
        case translationDescription = "description"
    }
}
