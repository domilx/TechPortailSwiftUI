//
//  LoginContentView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-08-27.
//

import SwiftUI

struct LoginContentView: View {

    @StateObject private var LoginSystem = LoginViewModel()
    @State private var didFail = false
    let alertTitle: String = "Login failed."
    
    var body: some View {

        VStack {
            Image("robotImage")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 350)
                .clipped()
                .overlay{
                    VStack{
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            Text("TechPortail")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                        }
                        .font(.body.weight(.medium))
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .foregroundColor(Color(.systemBackground))
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.secondary.opacity(0.8))
                        }
                        Spacer()
                    }
                }

                .mask {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                }
                .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.15), radius: 18, x: 0, y: 14)
            HStack{
                Text("Connexion")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
            VStack(spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .imageScale(.medium)
                        TextField("Email", text: $LoginSystem.email)
                        Spacer()
                    }
                    .offset(x: 20, y: 0)
                }
                .font(.body.weight(.medium))
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .clipped()
                .foregroundColor(Color(.displayP3, red: 244/255, green: 188/255, blue: 73/255))
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(.clear.opacity(0.25), lineWidth: 0)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.yellow.opacity(0.1)))
                }
                HStack(alignment: .firstTextBaseline) {
                    HStack {
                        Image(systemName: "key")
                            .imageScale(.medium)
                        SecureField("Password", text:$LoginSystem.password)
                        Spacer()
                    }
                    .offset(x: 20, y: 0)
                }
                .font(.body.weight(.medium))
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .clipped()
                .foregroundColor(Color(.displayP3, red: 244/255, green: 188/255, blue: 73/255))
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(.clear.opacity(0.25), lineWidth: 0)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.yellow.opacity(0.1)))
                }
                Button(action: {LoginSystem.login(completion: { bool in
                    self.didFail = bool.wrappedValue
                })}){
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text("Sign in")
                    }
                    .font(.body.weight(.medium))
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .foregroundColor(Color(.systemBackground))
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(UIColor.black))
                    }
                }
                .alert(isPresented: $didFail) {
                        Alert(
                            title: Text("Authentication Error"),
                            message: Text("Please try again with different credentials or at another time")
                        )
                    }
            }
            .padding(.horizontal)
        }
        Text("Made By Domenico & Raphaël")
            .foregroundColor(.secondary)
            .padding()
            .font(.footnote.weight(.medium))
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
