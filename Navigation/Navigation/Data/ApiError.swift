//
//  ApiError.swift
//  Navigation
//
//  Created by Денис Штоколов on 17.08.2022.
//

import Foundation
import UIKit

enum ApiError: Error {
    case loginFieldEmpty(viewController: UIViewController)
    case passFieldEmpty(viewController: UIViewController)
    case wrongLoginOrPassword(viewController: UIViewController)
    case registrationComplete(viewController: UIViewController)
    case shortPassword(viewController: UIViewController)
}

final class AppError {
    
    func handle(error: ApiError) {
        switch error {
        case .loginFieldEmpty(let viewController):
            let alert = UIAlertController(title: "login.field.is.empty.error".localized, message: "please.enter.login.alert".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .passFieldEmpty(let viewController):
            let alert = UIAlertController(title: "pass.field.is.empty.error".localized, message: "please.enter.pass.alert".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .wrongLoginOrPassword(let viewController):
            let alert = UIAlertController(title: "wrong.login.or.password.error".localized, message: "please.enter.correct.login.or.password.alert".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .registrationComplete(let viewController):
            let alert = UIAlertController(title: "complete!.error".localized, message: "registration.done.alert".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .shortPassword(let viewController):
            let alert = UIAlertController(title: "error!.error".localized, message: "the.password.must.contain.at.least.6.characters.alert".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
            
        }
    }
}
