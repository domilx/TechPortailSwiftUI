//
//  CalendarContentView.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-20.
//

import SwiftUI

struct CalendarContentView: View {
    @StateObject var eventViewModelFuture = EventViewModel()
    @StateObject var eventViewModelPast = EventViewModel()

    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("Events")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                    Spacer()
                }
                .padding(.top, 10)
                Divider()
                    .padding(.horizontal)
            }.onAppear() {
                eventViewModelFuture.fetchEventsList(isFuture: true, limit: 20)
                eventViewModelPast.fetchEventsList(isFuture: false, limit: 20)
            }
            ScrollView {
                
                HStack {
                    Text("New Events")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                
                ForEach(eventViewModelFuture.events?.events ?? [], id: \.id) { event in
                    EventCardView(title: event.name ?? "nil", description: event.eventDescription ?? "nil", dateRawBegin: event.dateDebut ?? "nil", dateRawEnd: event.dateFin ?? "nil", types: event.categories ?? [String](), id: event.id ?? "nil")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
                if(eventViewModelFuture.events?.events?.count == 0) {
                    Text("No new events")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
                HStack {
                    Text("Old Events")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()

                ForEach(eventViewModelPast.events?.events ?? [], id: \.id) { event in
                    EventCardView(title: event.name ?? "nil", description: event.eventDescription ?? "nil", dateRawBegin: event.dateDebut ?? "nil", dateRawEnd: event.dateFin ?? "nil", types: event.categories ?? [String](), id: event.id ?? "nil")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
            }
        }
    }
}

struct CalendarContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarContentView()
    }
}
