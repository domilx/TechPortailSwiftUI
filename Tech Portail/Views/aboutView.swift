//
//  aboutView.swift
//  Tech Portail
//
//  Created by Raphael Ethier on 2022-04-10.
//

import SwiftUI

struct aboutView: View {
    var body: some View {
        
        NavigationView{
            ScrollView{
                Text("À Propos")
                
                .navigationTitle("À propos de T4K")
            }
        }
    }
}

struct aboutView_Previews: PreviewProvider {
    static var previews: some View {
        aboutView()
    }
}
