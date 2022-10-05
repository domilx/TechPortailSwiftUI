//
// Created by Domenico Valentino on 2022-09-29.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {

    var email: String = ""
    var password: String = ""

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

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")

    }
}
