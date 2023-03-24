//
//  AuthorizationModel.swift
//  Navigation
//
//  Created by Денис Штоколов on 22.03.2023.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    
    @Persisted var login: String = ""
    @Persisted var password: String = ""
    @Persisted var isAuth: Bool = false
    
    func deleteUsers() {
        let realm = try? Realm()
        
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print(error)
        }
    }
}
