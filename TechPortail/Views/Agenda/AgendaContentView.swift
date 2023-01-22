//
//  AgendaContentView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-10-20.
//

import SwiftUI

struct AgendaContentView: View {
    @StateObject var eventViewModelFuture = EventViewModel()
    @StateObject var eventViewModelPast = EventViewModel()
    @AppStorage("isMentor") var isMentor: Bool = true
    @AppStorage("userId") var userId: String = "null"

    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            VStack{
                VStack {
                    HStack {
                        Text("Agenda")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding()
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
                    }
                    .padding(.top, 10)
                    Divider()
                        .padding(.horizontal)
                }.onAppear() {
                    eventViewModelFuture.fetchEventsList(isFuture: true, limit: 20)
                    eventViewModelPast.fetchEventsList(isFuture: false, limit: 20)
                    refreshEvents()
                }
                HStack {
                    Text("Upcoming Events")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }.padding()
                ScrollView {
                    ForEach(eventViewModelFuture.events?.events ?? [], id: \.id) { event in
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
            }
            .sheet(isPresented: $showingSheet) {
                CreateEvent(showModal: $showingSheet)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.automatic)
            }
        }
    }
    func refreshEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            eventViewModelFuture.fetchEventsList(isFuture: true, limit: 20)
            eventViewModelPast.fetchEventsList(isFuture: false, limit: 20)
            refreshEvents()
        }
    }
}

struct AgendaContentView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaContentView()
    }
}
