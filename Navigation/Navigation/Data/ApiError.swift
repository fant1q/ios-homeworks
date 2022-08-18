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
}

final class AppError {
    
    func handle(error: ApiError) {
        switch error {
        case .loginFieldEmpty(let viewController):
            let alert = UIAlertController(title: "Login field is empty", message: "Please enter login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .passFieldEmpty(let viewController):
            let alert = UIAlertController(title: "Password field is empty", message: "Please enter password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .wrongLoginOrPassword(let viewController):
            let alert = UIAlertController(title: "Wrong login or password", message: "Please enter correct login or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
