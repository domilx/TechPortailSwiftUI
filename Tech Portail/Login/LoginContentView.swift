//
//  LoginContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-08-27.
//

import SwiftUI

struct LoginContentView: View {

    @StateObject private var LoginSystem = LoginViewModel()
    
    let defaults = UserDefaults.standard
    
    var body: some View {

        VStack {
            HStack{
                Spacer()
                VStack{
                    Image(systemName: $LoginSystem.isAuthenticated.wrappedValue ? "lock.fill": "lock.open")
                        .padding(.bottom)
                    
                }
                Spacer()
            }
            .background($LoginSystem.isAuthenticated.wrappedValue ? Color.green: Color.red)
            Spacer().frame(height: 30)
            VStack{
                Text("Tech Portail")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 50) .bold())
                    .padding(.top)
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 70)
            }
            
            TextField("Email", text: $LoginSystem.email).padding(.top, 70.0).frame(width: 300)
            SecureField("Password", text: $LoginSystem.password).frame(width: 300)
                HStack {
                    Spacer()
                    Button("Login") {
                        LoginSystem.login()
                        print(defaults.value(forKey: "jsonwebtoken"))
                    }
                    Spacer()
                    Button("Signout") {
                        LoginSystem.signout()
                    }
                    Spacer()
                }
                .padding(.top)
            Spacer()
        }
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
