//
//  ViewControllerFactory.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.08.2022.
//

import Foundation
import UIKit

enum ViewControllerFactory {
    
    case profile(model: ProfileModel)
    case photos
    case post
    case info
    case favorites
    case map
    
    func makeViewController() -> UIViewController {
        switch self {
        case .profile(let model):
            return ProfileViewController(model: model)
        case .photos:
            return PhotosViewController(model: PhotosModel())
        case .post:
            return PostViewController(model: PostModel())
        case .info:
            return InfoViewController(model: InfoModel())
        case .favorites:
            return FavoritesViewController(model: FavoritesModel())
        case .map:
            return MapViewController(model: MapModel())
        }
    }
}
