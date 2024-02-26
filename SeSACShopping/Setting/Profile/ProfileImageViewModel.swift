//
//  ProfileImageViewModel.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/25/24.
//

import Foundation

class ProfileImageViewModel {
        
    var input = Observable(0)
    let output = Observable("")
    
    init() {
        input.bind { value in
            self.setProfileImage(value)
        }
    }

    func setProfileImage(_ value: Int) {
        if value == 0 {
            output.value = UserDefaultsManager.shared.image
        } else {
            UserDefaultsManager.shared.image = "profile\(value)"
            output.value = UserDefaultsManager.shared.image
        }
    }
    
    
}
