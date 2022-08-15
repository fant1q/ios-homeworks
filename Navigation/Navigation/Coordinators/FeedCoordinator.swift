//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    
    var navigation: UINavigationController
    
    func start() {
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func postTransition() {
        let vc = PostCoordinator(navigation: navigation)
        vc.start()
    }
}
