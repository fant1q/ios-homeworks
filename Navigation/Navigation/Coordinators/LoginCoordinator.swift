//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var navigation: UINavigationController
    
    func start() {
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func profileTransition(name: String, userService: UserService) {
        let vc = ProfileCoordinator(navigation: navigation, name: name, userService: userService)
        vc.start()
    }
}
