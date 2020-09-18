//
//  ApiRequest.swift
//  Flourish
//
//  Created by Milos Otasevic on 10/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

struct ApiRequest{
    let baseUrlString: String = "http://flourish.proserver.me"
    private let endpoint: Endpoint
    
    init(endpoint: Endpoint){
        self.endpoint = endpoint
    }
    
    var urlRequest: URLRequest?{
        let urlString = baseUrlString + "/" + endpoint.parameters
        guard let url = URL(string: urlString) else {return nil}
        return URLRequest(url: url)
    }
}
