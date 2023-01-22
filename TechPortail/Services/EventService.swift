//
//  EventService.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-10-05.
//

import Foundation
import SwiftUI
import Alamofire

class EventService {
    @AppStorage("token") var token: String = "null"
    
    func getHttpEvents(limit: Int, future: Bool, completion:@escaping (Events?) -> ()) {
        guard let url = URL(string: "http://api-env.eba-k3tngf8v.us-east-1.elasticbeanstalk.com/portail/event?limit="+String(limit)+"&future=" + String(future)) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json, text/plain, */*"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: Events.self) { response in
            DispatchQueue.main.async {
                completion(response.value)
            }
        }
    }
}
