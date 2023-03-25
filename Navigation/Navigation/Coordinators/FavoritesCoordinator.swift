//
//  FavoritesCoordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 24.03.2023.
//

import Foundation
import UIKit

final class FavoritesCoordinator: Coordinator {
    
    var navigation: UINavigationController
    
    func start() {}
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}
