//
//  PresenceService.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-11-27.
//

import Foundation
import SwiftUI
import Alamofire

class PresenceService {
    @AppStorage("token") var token: String = "null"
    
    func putPresence(debut: String, fin: String, event: String, completion:@escaping (Bool) -> ()) {
        guard let url = URL(string: "http://techapi-env.eba-wuyzhh27.us-east-1.elasticbeanstalk.com/portail/presence") else { return }
        
        let params = Presence(debut: debut, fin: fin, event: event)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json, text/plain, */*"
        ]
        
        AF.request(url, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
        }
        .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completion(true)
                case let .failure(error):
                    completion(false)
                }
            }
    }
}
