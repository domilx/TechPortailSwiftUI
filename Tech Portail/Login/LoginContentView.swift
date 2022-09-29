//
//  LoginContentView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-08-27.
//

import SwiftUI
import Alamofire

struct LoginContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State public var authenticationDidFail: Bool = false
    @State public var authenticationDidSucceed: Bool = false
    
    var body: some View {
            
            VStack {
                EmailTextField(email: $email)
                PasswordSecureField(password: $password)
                if authenticationDidFail {
                    Text("Information not correct. Try again.")
                        .offset(y: -10)
                        .foregroundColor(.red)
                }
                Button(action: {
                    AuthService().loginUser(sendEmail: $email, sendPass: $password)
                }) {
                   LoginButtonContent()
                }
                if authenticationDidSucceed {
                    Text("Login succeeded!")
                        .font(.headline)
                        .frame(width: 250, height: 80)
                        .background(Color.green)
                        .cornerRadius(20.0)
                        .foregroundColor(.white)
                        .animation(Animation.default)
                }
            }
            .padding()
        }
}

struct LoginButtonContent : View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct EmailTextField : View {
    @Binding var email: String
    var body: some View {
            return TextField("Email", text: $email)
                .padding()
                .background(Color(.lightGray))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
    }
}

struct PasswordSecureField : View {
    
    @Binding var password: String
    
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(Color(.lightGray))
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
