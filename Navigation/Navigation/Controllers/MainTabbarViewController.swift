//
//  MainTabbarViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.08.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let firstVC = TabBarFactory(flow: .first)
    private let secondVC = TabBarFactory(flow: .second)
    private let thirdVC = TabBarFactory(flow: .third)
    private let fourthVC = TabBarFactory(flow: .fourth)
    
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
