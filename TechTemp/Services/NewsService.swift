//
//  NewsService.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-11-27.
//

import Foundation
import SwiftUI
import Alamofire

class NewsService {
    @AppStorage("token") var token: String = "null"
    
    func getHttpNews(limit: Int, completion:@escaping (News?) -> ()) {
        //Get events du API
        guard let url = URL(string: "http://techapi-env.eba-wuyzhh27.us-east-1.elasticbeanstalk.com/portail/nouvelle?limit="+String(limit)) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json, text/plain, */*"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: News.self) { response in
            DispatchQueue.main.async {
                //"Return mais pas return " le responde.value pour etre lu dans EventViewModel.swift
                completion(response.value)
            }
        }
    }
}
