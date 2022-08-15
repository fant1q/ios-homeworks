//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

class PostCoordinator: Coordinator {
    
    weak var parentCoordinator: FeedCoordinator?
    var navigation: UINavigationController
    
    func start() {
        let postViewController = ViewControllerFactory.makeViewController(.post)
        navigation.pushViewController(postViewController(), animated: true)
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func infoTransition() {
        let vc = InfoCoordinator(navigation: navigation)
        vc.start()
    }
}
