//
//  TestResult.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct TestResult: Codable {
    let totalAvg: String
    let selfAwarenes: SelfAwarenes
    let selfManagement: SelfManagement
    let socialAwareness: SocialAwareness
    let relationshipManagement: RelationshipManagement
}

// MARK: - RelationshipManagement
struct RelationshipManagement: Codable {
    let relationshipManagementID: Int
    let relationshipManagementAvg: String

    enum CodingKeys: String, CodingKey {
        case relationshipManagementID = "relationshipManagementId"
        case relationshipManagementAvg
    }
}

// MARK: - SelfAwarenes
struct SelfAwarenes: Codable {
    let selfAwarenessID: Int
    let selfAwarenessAvg: String

    enum CodingKeys: String, CodingKey {
        case selfAwarenessID = "selfAwarenessId"
        case selfAwarenessAvg
    }
}

// MARK: - SelfManagement
struct SelfManagement: Codable {
    let selfManagementID: Int
    let selfManagementAvg: String

    enum CodingKeys: String, CodingKey {
        case selfManagementID = "selfManagementId"
        case selfManagementAvg
    }
}

// MARK: - SocialAwareness
struct SocialAwareness: Codable {
    let socialAwarenessID: Int
    let socialAwarenessAvg: String

    enum CodingKeys: String, CodingKey {
        case socialAwarenessID = "socialAwarenessId"
        case socialAwarenessAvg
    }
}
