//
//  FeedModel.swift
//  Navigation
//
//  Created by Денис Штоколов on 31.07.2022.
//

import Foundation

class FeedModel {
    
    private let password = "1234"
    
    func check(word: String) -> Bool {
        if word == password { return true
        } else { return false }
    }
}
