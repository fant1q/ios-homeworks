//
//  LoginServiceProtocol.swift
//  Navigation
//
//  Created by Денис Штоколов on 09.01.2023.
//

import Foundation
import FirebaseAuth

protocol LoginServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void)
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void)
    
}
