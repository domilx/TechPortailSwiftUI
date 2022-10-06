//
//  HomeContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-09-30.
//

import SwiftUI

struct HomeContentView: View {
    @AppStorage("token") var token: String = "null"
    @AppStorage("userName") var userName: String = "null"
    @AppStorage("userId") var userId: String = "null"
    @AppStorage("isLoggedIn") var loggedIn: Bool = false
    @AppStorage("isMentor") var isMentor: Bool = false
    
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
    @AppStorage("token") var token: String = "null"
    @AppStorage("userName") var userName: String = "null"
    @AppStorage("userId") var userId: String = "null"
    @AppStorage("isLoggedIn") var loggedIn: Bool = false
    @AppStorage("isMentor") var isMentor: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Welcome, \(userName.components(separatedBy: " ").first ?? "")!")
                    .font(.title2)
                    .padding(.leading, 30.0)
                Spacer()
            }
            Spacer()
            Button("Get events") {
                EventService().getEvents()
            }
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

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
