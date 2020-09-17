//
//  Translate.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct Translation: Codable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "game_id"
        case title = "game_title"
    }
}
