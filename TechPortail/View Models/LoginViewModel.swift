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

    func login(completion: @escaping (Binding<Bool>) -> Void) {

        AuthService().login(email: email, password: password) { result in
            switch result {
            case .success(_):
                completion(.constant(false))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.constant(true))
            }
        }
    }

    func signout() {

        self.loggedIn = false
        self.isMentor = false
        self.userName = "null"
        self.userId = "null"
        self.userName = "null"

    }
}
