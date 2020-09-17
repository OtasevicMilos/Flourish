//
//  DialogueMasterResultInrteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 16/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class DialogueMasterResultInrteractor: DialogueMasterResultUseCase{
    let provider: DialogueMasterResultProtocolProvider
    
    init(provider: DialogueMasterResultProtocolProvider) {
        self.provider = provider
    }
  
    func getResult(points: [Int], completion: @escaping (Response<DMResult>) -> ()) {
        self.provider.getResult(points: points, completion: completion)
    }
    
}
