//
//  User.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class User: Decodable{
    let id: Int
    let name: String
    let email: String
    let phoneNumber: String
    let birthYear: Int
    let isAdmin: Int
    let languageID: Int
    let profileImage: String
//    let seiTestAvg: Double?
    let totalScoreFromGames: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email
        case phoneNumber = "phone_number"
        case birthYear = "birth_year"
        case isAdmin = "is_admin"
        case languageID = "language_id"
        case profileImage = "profile_image"
//        case seiTestAvg = "sei_test_avg"
        case totalScoreFromGames = "total_score_from_games"
    }
}
