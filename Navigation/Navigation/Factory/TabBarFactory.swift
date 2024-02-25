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
        case login
        case feed
        case favorites
        case map
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
        case .login:
            let controller = LogInViewController()
            navigationController.tabBarItem = UITabBarItem(title: "profile.name".localized, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
            navigationController.delegate = LoginService() as? UINavigationControllerDelegate
            navigationController.setViewControllers([controller], animated: true)
        case .feed:
            let viewModel = FeedModel()
            let controller = FeedViewController(model: viewModel)
            navigationController.tabBarItem = UITabBarItem(title: "feed.name".localized, image: UIImage(systemName: "info.bubble"), selectedImage: UIImage(systemName: "info.bubble.fill"))
            navigationController.setViewControllers([controller], animated: true)
        case .favorites:
            let controller = FavoritesViewController(model: FavoritesModel())
            navigationController.tabBarItem = UITabBarItem(title: "favorites.name".localized, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
            navigationController.setViewControllers([controller], animated: true)
        case .map:
            let controller = MapViewController(model: MapModel())
            navigationController.tabBarItem = UITabBarItem(title: "map.name".localized, image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
            navigationController.setViewControllers([controller], animated: true)
            
        }
    }
}
