//
//  DialogueMasterProvider.swift
//  Flourish
//
//  Created by Milos Otasevic on 15/09/2020.
//  Copyright © 2020 Milos Otasevic. All rights reserved.
//

import Foundation

class DialogueMasterProvider: MainProvider, DialogueMasterProtocolProvider{
    
    func getHomeInformation(completion: @escaping (Response<DialogueMaster>) -> ()) {
        guard var request = ApiRequest(endpoint: .dialogueMaestro).urlRequest else { return }
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        
        webService.execute(request) { (response: Response<DialogueMasterResponse>) in
            switch response{
            case .success(let result):
                completion(.success(result.data))
            case .error(let error):
                completion(.error(error))
            }
        }
        
    }
    
}

struct DialogueMasterResponse: Codable {
    let data: DialogueMaster
}
