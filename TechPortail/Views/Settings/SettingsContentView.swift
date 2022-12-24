//
//  SettingsContentView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-10-04.
//

import SwiftUI

struct SettingsContentView: View {
  @StateObject private var LoginSystem = LoginViewModel()
  @AppStorage("isMentor") var isMentor: Bool = false
  @AppStorage("userId") var userId: String = "null"
  @AppStorage("token") var token: String = "null"
  @State private var showingAlertClip = false
  @State private var showingAlertLogout = false

  var body: some View {
    NavigationView {
      Form(content: {
        Section(header: Text("User")) {
          Button(action: {
            showingAlertLogout = true
          }) {
            Text("Log Out of TechPortail")
                    .foregroundColor(.red)
          }.alert(isPresented: $showingAlertLogout) {
            Alert(title: Text("Log Out"), message: Text("Are you sure you want to log out?"), primaryButton: .destructive(Text("Log Out")) {
                LoginSystem.signout()
            }, secondaryButton: .cancel())
          }
          Text("User ID: \(userId)")
          Text("User Type: \(isMentor ? "Mentor" : "Student")")
        }
        Button(action: {
          UIPasteboard.general.string = LoginSystem.token
            showingAlertClip = true
        }) {
          Text("Copy Token")
        }
                .alert(isPresented: $showingAlertClip) {
                  Alert(title: Text("Token Copied"), message: Text("Token copied to clipboard"), dismissButton: .default(Text("OK")))
                }
      })
      .navigationBarTitle("Settings")
    }
  }
}

struct SettingsContentView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsContentView()
  }
}
