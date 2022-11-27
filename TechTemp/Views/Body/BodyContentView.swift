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

struct BodyContentView_Previews: PreviewProvider {
    static var previews: some View {
        BodyContentView()
    }
}
