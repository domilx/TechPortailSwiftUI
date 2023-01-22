//
//  ContentView.swift
//  TechPortail
//
//  Created by Domenico Valentino on 2022-04-10.
//
import Foundation
import SwiftUI
import EventKit

struct ContentView: View {
    @StateObject private var LoginSystem = LoginViewModel()
    @AppStorage("isLoggedIn") var loggedIn: Bool = false
    @AppStorage("token") var token: String = "null"
    @State var isValid: Bool = false
    @State var keep: Bool = true
    @State var shouldLoad: Bool = true
    @State var checkCount: Int = 0
    
    var body: some View {
        
        if (!self.loggedIn || !isValid) {
            LoadingView(isShowing: $shouldLoad) {
                LoginContentView().onAppear{
                    isExp(isValid: isValid)
                    keep = true
                    LoginViewModel().isHasLogged(completion: { bool in
                        if(!bool.wrappedValue) {
                            
                        }
                    })
                }
            }
        }
        if(self.loggedIn && isValid){
            BodyContentView().onAppear(){
                keep = false
            }
        }
    }
    
    func shouldLoadFunc() {
        if (checkCount >= 2) {
            shouldLoad = false
        } else {
            shouldLoad = true
            print(shouldLoad)
        }
    }
    
    func isExp(isValid: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if(token != "null") {
                var payload64 = token.components(separatedBy: ".")[1]
                while payload64.count % 4 != 0 {
                        payload64 += "="
                }
                let payloadData = Data(base64Encoded: payload64,
                                           options:.ignoreUnknownCharacters)!
                let payload = String(data: payloadData, encoding: .utf8)!
                let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
                let exp = json["exp"] as! Int
                let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
                let isValid = expDate.compare(Date()) == .orderedDescending
                
                self.isValid = isValid
                checkCount += 1
                shouldLoadFunc()
            } else if (token == "null"){
                checkCount = 5
            }
            if(keep) {
                shouldLoadFunc()
                isExp(isValid: isValid)
            }
            
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
