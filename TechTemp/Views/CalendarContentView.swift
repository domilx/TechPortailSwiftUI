//
//  CalendarContentView.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-20.
//

import SwiftUI

struct CalendarContentView: View {
    @StateObject var eventViewModel = EventViewModel()

    var body: some View {
        VStack{
            
            Text("Calendar")
                .padding()
                .font(.title)
                .onAppear(){
                    eventViewModel.fetchEventsList()
                }
            ForEach(eventViewModel.events?.events ?? [], id: \.id) { event in
                EventCardView(event: .constant(event))
                    .padding()
            }
        }
    }
}

struct CalendarContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarContentView()
    }
}
