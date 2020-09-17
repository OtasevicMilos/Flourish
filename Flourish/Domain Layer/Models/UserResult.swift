//
//  UserResult.swift
//  Flourish
//
//  Created by Milos Otasevic on 14/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct UserResult: Codable {
    let gameCategoryID: Int
    let result: String

    enum CodingKeys: String, CodingKey {
        case gameCategoryID = "game_category_id"
        case result
    }
}
