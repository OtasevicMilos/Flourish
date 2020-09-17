//
//  QuizzProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class QuizzProvider: MainProvider, QuizzProtocolProvider{
    
    func getQuizz(completion: @escaping (Response<Quizz>) -> ()) {
        guard var request = ApiRequest(endpoint: .quizz).urlRequest else{ return}
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        
        webService.execute(request) { (response: Response<Quizz>) in
            switch response{
            case .success(let quizz):
                completion(.success(quizz))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func getQuizzResults(answers: [Int], completion: @escaping (Response<Bool>) -> ()) {
        guard var request = ApiRequest(endpoint: .quizzAnswers).urlRequest else {return}
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        
        let body: [String: [Any]] = [
            "answers" : answers
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData

        webService.execute(request) { (response: Response<ForgotPasswordResponse>) in
            switch response{
            case .success(let result):
                completion(.success(true))
            case .error(let error):
                completion(.error(error))
            }
            }
        }
        
    }

