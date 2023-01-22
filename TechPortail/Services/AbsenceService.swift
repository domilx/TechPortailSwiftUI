//
//  AbsenceService.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-11-27.
//

import Foundation
import SwiftUI
import Alamofire

class AbsenceService {
    @AppStorage("token") var token: String = "null"
    
    func putAbsence(event: String, completion:@escaping (Bool) -> ()) {
        guard let url = URL(string: "http://api-env.eba-k3tngf8v.us-east-1.elasticbeanstalk.com/portail/absence") else { return }
        
        let params = Absence(event: event)
        
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
                    completion(false)
                    print("success")
                case let .failure(error):
                    completion(true)
                    print(error)
                }
            }
    }
}
