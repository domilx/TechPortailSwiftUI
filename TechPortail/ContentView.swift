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
    
    var body: some View {
        
        if (!self.loggedIn || !isValid) {
            LoginContentView().onAppear{
                isExp(isValid: isValid, token: token)
                keep = true
            }
        }
        if(self.loggedIn && isValid){
            BodyContentView().onAppear(){
                keep = false
            }
        }
    }
    
    func isExp(isValid: Bool, token: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("checking")
            if(token != "null" && !isValid) {
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
            }
            if(keep) {
                isExp(isValid: isValid, token: token)
            }
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
