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
    @State private var forgot = false
        
    var body: some View {
        VStack{
            
            // Welcome
            VStack(spacing:15){
                Text("Tech Portail")
                    .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 42, fontColor: Color("yellow")))
                Text("Please sign in to continue.")
                    .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
                    .padding(.bottom, 10)
            }
            .padding(.top,45)
            Spacer()
            
            // Form
            VStack(spacing: 15){
                VStack(alignment: .center, spacing: 30){
                    VStack(alignment: .center) {
                        CustomTextfield(placeholder:
                                            Text("Email"),
                                        fontName: "RobotoSlab-Light",
                                        fontSize: 18,
                                        fontColor: Color.gray,
                                        username: $LoginSystem.email, isEmpty: true)
                        Divider()
                            .background(Color.gray)
                    }
                    VStack(alignment: .center) {
                        CustomSecureField(placeholder:
                                            Text("Password"),
                                          fontName: "RobotoSlab-Light",
                                          fontSize: 18,
                                          fontColor: Color.gray,
                                          password: $LoginSystem.password, isEmpty: true)
                        Divider()
                            .background(Color.gray)
                    }
                }
                HStack{
                    Spacer()
                    Button(action: {
                        self.forgot = true
                    }){
                        Text("Forgot Pass?")
                            .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 14, fontColor: Color.gray))
                    }.alert(isPresented: $forgot){
                        Alert(
                            title: Text("Oops.."),
                            message: Text("If you are facing issues with your account, please speak with a mentor")
                        )
                    }
                    
                }
            }
            .padding(.horizontal,35)
            
            //Button
            HStack{
                Button(action: {
                    LoginSystem.login(completion: { bool in
                        self.didFail = bool.wrappedValue
                    })
                }, label: {
                    ZStack{
                        Capsule()
                            .foregroundColor(Color("yellow"))
                            .frame(width: 120, height: 60)
                        HStack{
                            Text("Enter")
                                .modifier(CustomTextM(fontName: "RobotoSlab-Bold", fontSize: 17, fontColor: Color.white))
                            Image(systemName: "arrow.right")
                                .font(.title)
                                .foregroundColor(Color.white)
                        }
                        
                    }
                })
                .alert(isPresented: $didFail) {
                        Alert(
                            title: Text("Authentication Error"),
                            message: Text("Please try again with different credentials or at another time")
                        )
                    
                }
                .padding(.top,35)
            }.padding(.horizontal,35)
            
            Spacer()
                .frame(height: 400)
        }
    }
}

struct CustomTextM: ViewModifier {
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
