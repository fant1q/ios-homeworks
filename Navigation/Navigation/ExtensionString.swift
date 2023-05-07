//
//  ExtensionString.swift
//  Navigation
//
//  Created by Денис Штоколов on 04.05.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
