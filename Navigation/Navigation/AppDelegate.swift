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
    let appConfiguration = AppConfiguration.allCases.randomElement()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainCoordinator = MainCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
        self.window?.makeKeyAndVisible()
        NetworkService.request(for: appConfiguration!)
        
        return true
    }
}
