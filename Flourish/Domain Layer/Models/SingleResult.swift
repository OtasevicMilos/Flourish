//
//  SingleResult.swift
//  Flourish
//
//  Created by Milos Otasevic on 17/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct SingleResult: Codable {
    let questionCategoryName: String
    let questionCategoryAvg: String
    let questions: [SingleResultQuestion]

    enum CodingKeys: String, CodingKey {
        case questionCategoryName = "question_category_name"
        case questionCategoryAvg = "question_category_avg"
        case questions
    }
}

struct SingleResultQuestion: Codable {
    let questionTitle: String
    let answer: Int

    enum CodingKeys: String, CodingKey {
        case questionTitle = "question_title"
        case answer
    }
}
