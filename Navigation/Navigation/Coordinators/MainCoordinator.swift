//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {
    func startApplication() -> UIViewController {
        return MainTabBarViewController()
    }
}
