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
    @AppStorage("isLoggedIn") var loggedIn: Bool = false
    
    var body: some View {
        if !self.loggedIn {
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
