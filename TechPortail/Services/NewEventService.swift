//
//  NewEventService.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2023-01-13.
//

import Foundation
import SwiftUI
import Alamofire

class NewEventService {
    @AppStorage("token") var token: String = "null"
    
    func createEvent(event: NewEvent, completion:@escaping (Data?) -> ()) {
        guard let url = URL(string: "http://api-env.eba-k3tngf8v.us-east-1.elasticbeanstalk.com/portail/event") else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json, text/plain, */*"
        ]
        
        AF.request(url, method: .put, parameters: event, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
        }
        .validate(statusCode: 200..<600)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print(response.data)
                    print("success")
                case let .failure(error):
                    print(response)
                }
            }
    }
}
