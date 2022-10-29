//
//  BodyContentView.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-20.
//

import SwiftUI

struct BodyContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "techGrey")
   }
    var body: some View {
        VStack {
            HStack {
                Text("Team 3990")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(width: 500.0, height: 40.0)
                
            }.background(Color(UIColor(named: "techOrange")!))
                

            TabView {
                    HomeContentView()
                        .tabItem {
                            Image(systemName: "house.circle")
                            Text("Home")
                        }
                    CalendarContentView()
                        .tabItem {
                            Image(systemName: "calendar.circle")
                            Text("Calendar")
                    }
                    SettingsContentView()
                        .tabItem {
                            Image(systemName: "gear.circle")
                            Text("Settings")
                    }
            }
        }
    }
}

struct BodyContentView_Previews: PreviewProvider {
    static var previews: some View {
        BodyContentView()
    }
}
