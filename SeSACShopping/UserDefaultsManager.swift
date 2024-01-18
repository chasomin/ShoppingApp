//
//  UserDefaultsManager.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    enum UDKey: String {
        case nickname
        case search
    }
    
    let ud = UserDefaults.standard
    
    var nickname: String {
        get {
            ud.string(forKey: UDKey.nickname.rawValue) ?? ""
        }
        set {
            ud.set(newValue, forKey: UDKey.nickname.rawValue)
        }
    }
    
    var search: [String] {
        get {
            ud.stringArray(forKey: UDKey.search.rawValue) ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.search.rawValue)
        }
    }
    

}

