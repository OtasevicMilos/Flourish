//
//  MainProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class MainProvider{
    let webService: WebService
    
    init(webService: WebService = WebServiceProvide(session: DataNetworkSession())){
        self.webService = webService
    }
}
