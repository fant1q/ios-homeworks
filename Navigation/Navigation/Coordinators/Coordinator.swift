//
//  Coordinator.swift
//  Navigation
//
//  Created by Денис Штоколов on 10.08.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var navigation: UINavigationController { get }
    func start()
}
