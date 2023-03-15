//
//  LoginInspector.swift
//  Navigation
//
//  Created by Денис Штоколов on 15.07.2022.
//

import Foundation
import FirebaseAuth

class LoginInspector: LogInViewControllerDelegate {
    
    private let checkerService: LoginServiceProtocol = LoginService()
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void) {
        checkerService.checkCredentials(email: email, password: password, completion: completion)
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void) {
        checkerService.signUp(email: email, password: password, completion: completion)
    }
}

protocol LoginFactory {
    static func loginInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    static func loginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
