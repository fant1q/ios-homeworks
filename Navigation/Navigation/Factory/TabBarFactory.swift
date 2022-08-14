//
//  TabBarFactory.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

final class TabBarFactory {
    
    enum Flow {
        case first
        case second
    }
    
    let navigationController: UINavigationController = UINavigationController()
    let flow: Flow
    
    init(
        flow: Flow
    ) {
        self.flow = flow
        startModule()
    }
    
    func startModule() {
        switch flow {
        case .first:
            let controller = LogInViewController()
            navigationController.tabBarItem.image = UIImage(systemName: "person")
            navigationController.tabBarItem.title = "Profile"
            navigationController.delegate = LoginInspector() as? UINavigationControllerDelegate
            navigationController.setViewControllers([controller], animated: true)
        case .second:
            let viewModel = FeedModel()
            let controller = FeedViewController(model: viewModel)
            navigationController.tabBarItem.image = UIImage(systemName: "server.rack")
            navigationController.tabBarItem.title = "Feed"
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}
