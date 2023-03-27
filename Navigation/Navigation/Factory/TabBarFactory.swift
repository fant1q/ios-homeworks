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
        case third
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
            navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
            navigationController.delegate = LoginInspector() as? UINavigationControllerDelegate
            navigationController.setViewControllers([controller], animated: true)
        case .second:
            let viewModel = FeedModel()
            let controller = FeedViewController(model: viewModel)
            navigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "info.bubble"), selectedImage: UIImage(systemName: "info.bubble.fill"))
            navigationController.setViewControllers([controller], animated: true)
        case .third:
            let controller = FavoritesViewController(model: FavoritesModel())
            navigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
            navigationController.setViewControllers([controller], animated: true)
            
        }
    }
}
