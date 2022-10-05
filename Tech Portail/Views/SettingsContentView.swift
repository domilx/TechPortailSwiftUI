//
//  SettingsContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-10-04.
//

import SwiftUI

struct SettingsContentView: View {
    @StateObject private var LoginSystem = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("User")) {
                        Toggle(isOn: .constant(true), label: {
                            Text("Remember Info")
                        })
                        Button(action: {
                            LoginSystem.signout()
                        }) {
                            Text("Log Out & Clear Cache")
                        }
                    }
                }
                Text("iOS App Written by:").foregroundColor(.gray).font(.caption)
                Text("Domenico Valentino & Raphael Ethier").foregroundColor(.gray).font(.caption)
                Text("Server Written by:").foregroundColor(.gray).font(.caption)
                Text("Camil Bisson & Domenico Valentino").foregroundColor(.gray).font(.caption)
            }.navigationTitle("Settings")
        }
    }
}

struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContentView()
    }
}
