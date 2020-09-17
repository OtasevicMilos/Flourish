//
//  Response.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

enum Response<T>{
    case success(T)
    case error(Error)
}
