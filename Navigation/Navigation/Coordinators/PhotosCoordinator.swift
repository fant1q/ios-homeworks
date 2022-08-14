//
//  PhotosCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

class PhotosCoordinator: Coordinator {
    
    weak var parentCoordinator: ProfileCoordinator?
    var navigation: UINavigationController
    
    func start() {
        let photosViewController = ViewControllerFactory.makeViewController(.photos)
        navigation.pushViewController(photosViewController(), animated: true)
        navigation.navigationBar.isHidden = false
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}
