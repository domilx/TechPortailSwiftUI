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

    func login() {

        AuthService().login(email: email, password: password) { result in
            switch result {
            case .success(_):
                print("Login Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func signout() {

        self.loggedIn = false
        self.userName = "null"
        self.userId = "null"
        self.userName = "null"
        self.isMentor = false

    }
}
