//
//  SettingsContentView.swift
//  TechTemp
//
//  Created by Domenico Valentino on 2022-10-04.
//

import SwiftUI

struct SettingsContentView: View {
  @StateObject private var LoginSystem = LoginViewModel()
  @AppStorage("isMentor") var isMentor: Bool = false
  @AppStorage("userId") var userId: String = "null"

  var body: some View {
    NavigationView {
      Form(content: {
        Section(header: Text("User")) {
          Toggle(
            isOn: .constant(true),
            label: {
              Text("Remember Info")
            })
          Button(action: {
            LoginSystem.signout()
          }) {
            Text("Log Out & Clear Cache")
                  .foregroundColor(.red)
         }
        }
        Section(header: Text("Debug Info")) {
          Text($isMentor.wrappedValue ? "User Is Mentor" : "User Is Student")
          Text("User Id: " + $userId.wrappedValue)
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
