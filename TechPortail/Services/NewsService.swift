//
//  NewsService.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-11-27.
//

import Foundation
import SwiftUI
import Alamofire

class NewsService {
    @AppStorage("token") var token: String = "null"
    
    func getHttpNews(limit: Int, completion:@escaping (News?) -> ()) {
        guard let url = URL(string: "http://api-env.eba-k3tngf8v.us-east-1.elasticbeanstalk.com/portail/nouvelle?limit="+String(limit)) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json, text/plain, */*"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: News.self) { response in
            DispatchQueue.main.async {
                completion(response.value)
            }
        }
    }
}
