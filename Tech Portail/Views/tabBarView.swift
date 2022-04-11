//
//  tabBarView.swift
//  Tech Portail
//
//  Created by Raphael Ethier on 2022-04-10.
//

import SwiftUI

struct tabBarView: View {
    var body: some View {
        
        TabView {
            homeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
         
            eventsView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Évènements")
                }
         
            aboutView()
                .tabItem {
                    Image(systemName: "person")
                    Text("À propos")
                }
         
    
        }
    }
}

struct tabBarView_Previews: PreviewProvider {
    static var previews: some View {
        tabBarView()
    }
}
