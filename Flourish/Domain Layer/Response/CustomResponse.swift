//
//  CustomResponse.swift
//  Flourish
//
//  Created by Milos Otasevic on 11/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

enum CustomResponse<T>{
    case success(T)
    case error(String)
}
