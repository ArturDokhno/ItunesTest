//
//  UserDefaultsManager.swift
//  ItunesTest
//
//  Created by Артур Дохно on 26.08.2022.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKey: String {
        case users
        case activeUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKey.users.rawValue
    let activeUserKey = SettingKey.activeUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data  {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    var activeUser: User? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data  {
                return try! PropertyListDecoder().decode(User.self, from: data)
            } else {
                return nil
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
    }
    
    private init() { }
    
    func saveUser(firstName: String, secondName: String, phone: String, email: String, password: String, age: Date) {
        let user = User(firstName: firstName, secondName: secondName, phone: phone, email: email, password: password, age: age)
        users.insert(user, at: 0)
    }
    
    func saveActivUser(user: User) {
        activeUser = user
    }
    
}
