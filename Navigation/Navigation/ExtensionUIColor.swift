//
//  ExtensionUIColor.swift
//  Navigation
//
//  Created by Денис Штоколов on 07.05.2023.
//

import Foundation
import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lighMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lighMode : darkMode
        }
    }
}
