//
//  Checker.swift
//  Navigation
//
//  Created by Денис Штоколов on 15.07.2022.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login = "Cat"
    
    private let password = "1234"
    
    private init() {}
    
    func check(logIn: String, passWord: String) -> Bool {
        if logIn.hash == login.hash && passWord.hash == password.hash {
            return true
        } else { return false }
    }
}
