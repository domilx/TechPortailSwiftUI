//
//  HomeContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-09-30.
//

import SwiftUI

struct HomeContentView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                HomeView()
                .navigationTitle("Tech Portail")
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
                NavigationLink(destination: SettingsContentView(), label: {
                    Image(systemName: "gear")
                })
                .padding([.bottom, .trailing])
            }
        }
    }
}

struct ListView: View {
    //on "subscribe" au event view model
    @StateObject var eventViewModel = EventViewModel()

    var body: some View {
        Text("Liste de events")
            .onAppear(){
                //quand le text est render on fetch la liste de events avec le EventViewModel
                eventViewModel.fetchEventsList()
            }
        //Display ce qu'on veut et le ?? nil est un temp value pour le temp qu'il download le data
        Text(eventViewModel.events?.events?.first?.name ?? "nil")
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
