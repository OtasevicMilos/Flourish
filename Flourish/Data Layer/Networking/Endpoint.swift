//
//  Endpoint.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

enum Endpoint{
    case login
    case register
    case verifyMail
    case resetCode(userID: Int)
    case homeScreen
    case resetPassword
    case dialogueMaestro
    case dialogueMaestroResults
    case quizz
    case quizzAnswers
    case allCategories
    case singleCategory(categoryID: Int)
    
    var parameters: String{
        switch self {
        case .login:
            return "api/auth/login"
        case .register:
            return "api/auth/register"
        case .verifyMail:
            return "api/auth/verify-email"
        case .resetCode(let userID):
            return "api/auth/send-verification-code?userId=\(userID)"
        case .homeScreen:
            return "api/home-screen"
        case .resetPassword:
            return "api/forgot-password"
        case .dialogueMaestro:
            return "api/dialogue-maestro/questions-with-answers"
        case .dialogueMaestroResults:
            return "api/dialogue-maestro/send-results"
        case .quizz:
            return "api/questions"
        case .quizzAnswers:
            return "api/store-answers"
        case .allCategories:
            return "api/get-results"
        case .singleCategory(let categoryID):
            return "api/get-single-category-results/\(categoryID)"
        }
        
    }
}
