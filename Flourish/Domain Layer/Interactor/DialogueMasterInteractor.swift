//
//  DialogueMasterInteractor.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class DialogueMasterInteractor: DialogueMasterUseCase{
    let provider: DialogueMasterProtocolProvider
    
    init(provider: DialogueMasterProtocolProvider) {
        self.provider = provider
    }
    
    func getHomeInformation(completion: @escaping (Response<DialogueMaster>) -> ()) {
        self.provider.getHomeInformation(completion: completion)
    }
    
}
