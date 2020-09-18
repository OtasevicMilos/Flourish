//
//  Quizz.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation


struct Quizz: Codable {
    let time: Int
    let questions: [QuizzQuestion]
}

struct QuizzQuestion: Codable {
    let id: Int
    let questionCategoryID: Int
    let image: String
    let translations: [QuizzTranslation]
    
    enum CodingKeys: String, CodingKey {
        case id
        case questionCategoryID = "question_category_id"
        case image
        case translations
    }
}

struct Image: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL  = "imgQuestionSVG"
    }
}

struct QuizzTranslation: Codable {
    let title: String
    let question: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case question
    }
}
