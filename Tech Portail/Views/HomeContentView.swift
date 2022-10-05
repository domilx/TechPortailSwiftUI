//
//  HomeContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-09-30.
//

import SwiftUI

struct HomeContentView: View {
    @AppStorage("userName") var userName: String = "Loading..."
    @AppStorage("userId") var userId: String = "Loading..."
    @AppStorage("token") var token: String = "Loading..."
    
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
    @AppStorage("userName") var userName: String = "Loading..."
    @AppStorage("userId") var userId: String = "Loading..."
    @AppStorage("token") var token: String = "Loading..."
    
    var body: some View {
        VStack{
            HStack{
                Text("Welcome, \(userName.components(separatedBy: " ").first ?? "")!")
                    .font(.title2)
                    .padding(.leading, 30.0)
                Spacer()
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
