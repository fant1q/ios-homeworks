//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Денис Штоколов on 18.05.2023.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    
    let laContext = LAContext()
    var error: NSError?
    lazy var isBiometricAuthEnable: Bool = {
        laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }()
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                 localizedReason: "Авторизуйтесь для доступа к аккаунту"
                                 ) { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Попробуйте другой метод, \(error.localizedDescription)")
                    authorizationFinished(false)
                    return
                }
                authorizationFinished(true)
            }
        }
    }
}
