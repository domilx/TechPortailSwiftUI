//
//  NewsViewModel.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-11-27.
//

import Foundation
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var news: News?
    func fetchNewsList(){
        NewsService().getHttpNews(limit: 3, completion: { (news) in
            self.news = news
        })
    }
}
