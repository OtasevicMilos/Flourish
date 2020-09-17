//
//  VerificationUseCase.swift
//  Flourish
//
//  Created by Milos Otasevic on 11/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol VerificationUseCase{
    func verifyMail(code: String, id: Int, completion: @escaping (Response<String>) -> ())
    func resetCode(id: Int, completion: @escaping (Response<Bool>) -> ())
}
