//
//  LoginProviderProtocol.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol LoginProviderProtocol{
    func login(email: String, password: String, completion: @escaping (Response<User>) -> Void)
}
