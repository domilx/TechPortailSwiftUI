//
//  ContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-04-10.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var LoginSystem = LoginViewModel()
    @AppStorage("token") var token: String = "nil"
    
    var body: some View {
        if token == "nil" {
            LoginContentView()
        } else {
            HomeContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
