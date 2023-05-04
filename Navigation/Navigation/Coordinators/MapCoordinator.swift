//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 30.04.2023.
//

import Foundation
import UIKit

final class MapCoordinator: Coordinator {
    
    var navigation: UINavigationController
    
    func start() {}
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}
