//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.08.2022.
//

import Foundation
import UIKit

class InfoCoordinator: Coordinator {
    
    var navigation: UINavigationController
    
    func start() {
        let infoViewController = ViewControllerFactory.makeViewController(.info)
        let navigation = UINavigationController(rootViewController: infoViewController())
        infoViewController().title = "info.name".localized
        navigation.present(infoViewController(), animated: true)
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}
