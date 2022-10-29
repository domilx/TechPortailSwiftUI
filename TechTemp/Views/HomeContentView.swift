//
//  HomeContentView.swift
//  TechTemp
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

    var body: some View {
        VStack{
            HStack{
                
                Text("Welcome, \(userName.components(separatedBy: " ").first ?? "")!")
                    .padding(.top)
                    .font(.title2)
                    .padding(.leading, 30.0)
                    .onAppear(){
                        eventViewModel.fetchEventsList()
                    }
                Spacer()
            }
            Spacer()
            ListView()
            Spacer()
            HStack{
                Spacer()
            }
        }
    }
}

struct ListView: View {
    //on "subscribe" au event view model
    @StateObject var eventViewModel = EventViewModel()

    var body: some View {
        VStack{
            Text("Liste de events")
                .font(.title)
                .onAppear(){
                    eventViewModel.fetchEventsList()
                }
            ForEach(eventViewModel.events?.events ?? [], id: \.id) { event in
                
                Text(event.name ?? "nil")
                    .padding()
                
            }
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
