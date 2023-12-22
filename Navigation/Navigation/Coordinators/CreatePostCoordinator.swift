//
//  CreatePostCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 05.11.2023.
//

import UIKit

class CreatePostCoordinator: Coordinator {
    
    var navigation: UINavigationController
    
    func start() {
        let postViewController = ViewControllerFactory.makeViewController(.createPost)
        navigation.present(postViewController(), animated: true)
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}
