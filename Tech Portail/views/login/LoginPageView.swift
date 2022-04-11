//
//  LoginPageView.swift
//  Tech Portail
//
//  Created by Domenico Valentino on 2022-04-10.
//

import SwiftUI

struct LoginPageView: View {
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
        
        @State var username: String = ""
        @State var password: String = ""
        
        var body: some View {
            NavigationView{
                VStack {
                    TitleText()
                    TitleImage()
                    TextField("Utilisateur", text: $username)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    SecureField("Mot de passe", text: $password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        
                        print("login tapped!")
                    }){
                        NavigationLink(destination: TempHomeView()){
                            LoginButtonContent()
                        }
                    }
                    Spacer()
                    
                }.padding()
            }
        }
}

struct TitleText: View {
    var body: some View {
        Text("Bienvenue!")
            .font(.largeTitle)
            .padding(.bottom, 20)
    }
}

struct TitleImage: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 10)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}



struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
