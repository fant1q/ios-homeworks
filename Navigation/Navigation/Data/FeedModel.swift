//
//  FeedModel.swift
//  Navigation
//
//  Created by Денис Штоколов on 31.07.2022.
//

import Foundation

class FeedModel {
    
    private let password = "Password"
    
    func check(word: String) -> Bool {
        if word == password { return true
        } else { return false }
    }
}
