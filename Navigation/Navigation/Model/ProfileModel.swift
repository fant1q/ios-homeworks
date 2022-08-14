//
//  ProfileModel.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.08.2022.
//

import Foundation
import UIKit

class ProfileModel {
    
    let title: String = "Profile"
    var userService: UserService
    var name: String
    
    init(userService: UserService, name: String){
        self.name = name
        self.userService = userService
    }
}
