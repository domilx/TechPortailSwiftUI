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
    
    @AppStorage("isMentor") var isMentor: Bool = false
    @AppStorage("userId") var userId: String = "null"

    @State private var showingSheet = false
    

    var body: some View {
            HStack {
                Text("Tech Portail")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                    .onAppear() {
                        eventViewModel.fetchEventsList(isFuture: true, limit: 4)
                        newsViewModel.fetchNewsList()
                    }
                Spacer()
                if(isMentor){
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text("New event")
                        Image(systemName: "plus")
                    }
                    .padding()
                    .font(.headline)
                    .fontWeight(.medium)
                }
            }.padding(.top, 10)
            Divider().padding(.horizontal)
        ScrollView{
            VStack{
                HStack {
                    Text("Upcoming Events")
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
                            HStack{
                                NavigationLink(destination: EventDetailsView(title: event.name ?? "nil", description: event.eventDescription ?? "nil", dateRawBegin: event.date_debut ?? "nil", dateRawEnd: event.date_fin ?? "nil", types: event.categories ?? [String](), id: event.id ?? "nil", presences: event.presents ?? [Present](), absences: event.absents ?? [Absent]())) {
                                    EventCardView(title: event.name ?? "nil", description: event.eventDescription ?? "nil", dateRawBegin: event.date_debut ?? "nil", dateRawEnd: event.date_fin ?? "nil", types: event.categories ?? [String](), id: event.id ?? "nil", presences: event.presents, absences: event.absents ?? [Absent]())
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                }
                                Spacer()
                            }
                            
                            Divider().padding(.horizontal)
                            
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
        .sheet(isPresented: $showingSheet) {
            CreateEvent(showModal: $showingSheet)
                .presentationDetents([.large])
                .presentationDragIndicator(.automatic)
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
