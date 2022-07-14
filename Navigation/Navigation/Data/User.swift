//
//  User.swift
//  Navigation
//
//  Created by Денис Штоколов on 12.07.2022.
//

import Foundation
import UIKit

class User {
    
    var name: String
    var avatar: UIImageView
    var status: String
    
    init(name: String, avatar: UIImageView, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    func userCheck(name: String) -> (User?)
}

class CurrentUserService: UserService {
    
    let user = User(name: "Cat", avatar: UIImageView(image: (UIImage(named: "cyberCat-1"))), status: "ololo")
    
    func userCheck(name: String) -> (User?) {
        if name == user.name {
            return user
        } else { return nil }
    }
}

class TestUserService: UserService {
    
    let user = User(name: "test name", avatar: UIImageView(image: UIImage()), status: "test status")
    
    func userCheck(name: String) -> (User?) {
        if name == user.name {
            return user
        } else { return nil }
    }
}
