//
// Created by Domenico Valentino on 2022-09-29.
//

import Foundation

class LoginViewModel: ObservableObject {

    var email: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false

    func login() {

        let defaults = UserDefaults.standard

        AuthService().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func signout() {

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "userName")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }

    }

}
