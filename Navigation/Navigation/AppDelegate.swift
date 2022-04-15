//
//  AppDelegate.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let feedViewController = FeedViewController()
        let profileViewController = ProfileViewController()
        let navigationVC1 = UINavigationController(rootViewController: feedViewController)
        let navigationVC2 = UINavigationController(rootViewController: profileViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationVC1, navigationVC2
        ]
        let image1 = UIImage(systemName: "server.rack")
        let image2 = UIImage(systemName: "person")
        navigationVC1.tabBarItem.image = image1
        navigationVC2.tabBarItem.image = image2
        navigationVC1.tabBarItem.title = "Feed"
        navigationVC2.tabBarItem.title = "Profile"
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

