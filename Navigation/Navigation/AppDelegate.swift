//
//  AppDelegate.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appConfiguration = AppConfiguration.allCases.randomElement()
    let coreDataService = CoreDataService.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainCoordinator = MainCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
        self.window?.makeKeyAndVisible()
        FirebaseApp.configure()
        NetworkService.request(for: appConfiguration!)
//        coreDataService.deleteAllData()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
