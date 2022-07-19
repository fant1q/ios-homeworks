//
//  LoginInspector.swift
//  Navigation
//
//  Created by Денис Штоколов on 15.07.2022.
//

import Foundation

class LoginInspector: LogInViewControllerDelegate {
    func checkLoginPass(log: String, pass: String) -> Bool {
        
        let result: Bool = Checker.shared.check(logIn: log, passWord: pass)
        return result
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
