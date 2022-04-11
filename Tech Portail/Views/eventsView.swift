//
//  eventsView.swift
//  Tech Portail
//
//  Created by Raphael Ethier on 2022-04-10.
//

import SwiftUI

struct eventsView: View {
    var body: some View {
        
        NavigationView{
            ScrollView{
                Text("Évènements")
                
                .navigationTitle("Évènements à venir")
            }
        }
    }
}

struct eventsView_Previews: PreviewProvider {
    static var previews: some View {
        eventsView()
    }
}
