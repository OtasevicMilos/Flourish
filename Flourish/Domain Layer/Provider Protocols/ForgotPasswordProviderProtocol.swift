//
//  ForgotPasswordProviderProtocol.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

protocol ForgotPasswordProviderProtocol{
    func resetPassword(mail: String, completion: @escaping (Response<CustomResponse<String>>) -> ())
}
