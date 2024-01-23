//
//  UserDefaultsManager.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    enum UDKey: String {
        case nickname
        case search
        case like
        case image
        case userState
    }
    
    let ud = UserDefaults.standard
    
    var userState: Bool {
        get {
            ud.bool(forKey: UDKey.userState.rawValue)
        }
        set {
            ud.set(newValue, forKey: UDKey.userState.rawValue)
        }
    }
    
    var nickname: String {
        get {
            ud.string(forKey: UDKey.nickname.rawValue) ?? ""
        }
        set {
            ud.set(newValue, forKey: UDKey.nickname.rawValue)
        }
    }
    
    var image: String {
        get {
            ud.string(forKey: UDKey.image.rawValue) ?? ""
        }
        set {
            ud.set(newValue, forKey: UDKey.image.rawValue)
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
    
    var like: [String] {
        get {
            ud.stringArray(forKey: UDKey.like.rawValue) ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.like.rawValue)
        }
    }

    var likeLabel: NSMutableAttributedString {
        let fullText = "\(like.count)개의 상품을 좋아하고 있어요!"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: "\(like.count)개의 상품")
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.point, range: range)

        return attributedString

    }
}

