//
//  LoginService.swift
//  Navigation
//
//  Created by Денис Штоколов on 09.01.2023.
//

import Foundation
import FirebaseAuth

final class LoginService: LoginServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil,
                  let result = result else {
                completion(.failure(error! as NSError))
                return
            }
            completion(.success(result))
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil,
                  let result = result else {
                completion(.failure(error! as NSError))
                return
            }
            completion(.success(result))
        }
    }
}
