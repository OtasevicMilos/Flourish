//
//  RegisterProviderProtocol.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol RegisterProviderProtocol{
    func register(name: String, email: String, password: String, passwordConfirmation: String, phoneNumber: String, birthYear: String,  completion: @escaping (Response<CustomResponse<Int>>) -> Void)
}
