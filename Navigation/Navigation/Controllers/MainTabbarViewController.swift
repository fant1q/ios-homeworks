//
//  MainTabbarViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.08.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let firstVC = TabBarFactory(flow: .login)
    private let secondVC = TabBarFactory(flow: .feed)
    private let thirdVC = TabBarFactory(flow: .favorites)
    private let fourthVC = TabBarFactory(flow: .map)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            firstVC.navigationController,
            secondVC.navigationController,
            thirdVC.navigationController,
            fourthVC.navigationController
        ]
    }
}
