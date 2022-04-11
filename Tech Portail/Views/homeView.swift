//
//  homeView.swift
//  Tech Portail
//
//  Created by Raphael Ethier on 2022-04-10.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        
        NavigationView{
            
            ScrollView{
                Text("Accueil")
                
                
            }
            .navigationTitle("Accueil")
        }
        
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
