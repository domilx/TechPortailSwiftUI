//
//  HomeContentView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-09-30.
//

import SwiftUI

struct HomeContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                HomeView()
            }
        }
    }
}

struct HomeView: View {
    @AppStorage("userName") var userName: String = "null"
    @StateObject var eventViewModel = EventViewModel()
    @StateObject var newsViewModel = NewsViewModel()
    

    var body: some View {
        ScrollView{
            VStack{
                HStack {
                    Text("TechPortail")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                        .onAppear() {
                            eventViewModel.fetchEventsList(isFuture: false, limit: 1)
                            newsViewModel.fetchNewsList()
                        }
                    Spacer()
                }
                Divider().padding(.horizontal)
                HStack {
                    Text("Hot Events")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()

                    if(eventViewModel.events?.events?.count == 0) {
                        Text("No new events")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                    } else {
                        ForEach(eventViewModel.events?.events ?? [], id: \.id) { event in
                            EventCardView(title: event.name ?? "nil", description: event.eventDescription ?? "nil", dateRawBegin: event.dateDebut ?? "nil", dateRawEnd: event.dateFin ?? "nil", types: event.categories ?? [String](), id: event.id ?? "nil", presences: event.presents, absences: event.absents  ?? [Absent]())
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                    }
                
                HStack {
                    Text("News")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                ForEach(newsViewModel.news?.nouvelle ?? [], id: \.id) { news in
                    NewsCardView(title: news.name ?? "nil", description: news.nouvelleDescription ?? "nil", dateRaw: news.date ?? "nil")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
                Spacer()
            }
            
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
