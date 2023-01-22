//
// Created by Domenico Valentino on 2022-09-29.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {

    var email: String = ""
    var password: String = ""
    
    @AppStorage("token") var token: String = "null"
    @AppStorage("userName") var userName: String = "null"
    @AppStorage("userId") var userId: String = "null"
    @AppStorage("isLoggedIn") var loggedIn: Bool = false
    @AppStorage("isMentor") var isMentor: Bool = false
    @AppStorage("email") var userEmail: String = "null"
    @AppStorage("pass") var pass: String = "null"

    func login(completion: @escaping (Binding<Bool>) -> Void) {

        AuthService().login(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(.constant(false))
                self.userEmail = self.email
                self.pass = self.password
            case .failure(let error):
                print(error.localizedDescription)
                completion(.constant(true))
            }
        }
    }
    
    func isHasLogged(completion: @escaping (Binding<Bool>) -> Void) {
        if (userEmail != "null" && pass != "null") {
            self.email = self.userEmail
            self.password = self.pass
            self.login(completion: { bool in
                completion(bool)
            })
        }
    }

    func signout() {

        self.loggedIn = false
        self.isMentor = false
        self.userName = "null"
        self.userId = "null"
        self.userName = "null"
        self.userEmail = "null"
        self.pass = "null"

    }
}
