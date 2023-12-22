//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
    var navigation: UINavigationController
    var name: String
    var userService: UserService
    
    func start() {
        let profileViewController = ViewControllerFactory.makeViewController(.profile(model: ProfileModel(userService: userService, name: name)))
        navigation.pushViewController(profileViewController(), animated: true)
    }
    
    init(navigation: UINavigationController, name: String, userService: UserService) {
        self.navigation = navigation
        self.name = name
        self.userService = userService
    }
    
    func photosTransition() {
        let vc = PhotosCoordinator(navigation: navigation)
        vc.start()
    }
    func createPostTransition() {
        let vc = CreatePostCoordinator(navigation: navigation)
        vc.start()
    }
}
