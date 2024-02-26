//
//  ProfileViewModel.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/24/24.
//

import Foundation

enum NicknameError: Error {
    case empty
    case symbol
    case number
    case length
    case cerrent
}

final class ProfileViewModel {
    var inputNickName = Observable("")
    var inputDoneButton = Observable("")
    var inputUserImage = Observable("")
    
    var outputNickName = Observable("")
    var outputVaildState = Observable(false)
    var outputUserImage = Observable("")
    
    init() {
        inputNickName.bind { value in
            self.vaildNickName(value)
            
        }
        inputDoneButton.bind { value in
            self.saveNickname(value)
        }
        inputUserImage.bind { value in
            self.checkUserImage(value)
        }
    }
    
    
    private func validateUserInputError(text: String) throws -> Bool {
        guard !text.isEmpty else {
            throw NicknameError.empty
        }
        try text.forEach {
            guard !"0123456789".contains($0) else {
                throw NicknameError.number
            }
            guard !"@#$%".contains($0) else {
                throw NicknameError.symbol
            }
        }
        guard !(text.count < 2 || text.count > 9) else {
            throw NicknameError.length
        }
        guard text != UserDefaultsManager.shared.nickname else {
            throw NicknameError.cerrent
        }
        return true
    }
    
    private func vaildNickName(_ value: String) {
        do {
            let _ = try validateUserInputError(text: value)
            outputNickName.value = "사용할 수 있는 닉네임이에요."
            outputVaildState.value = true

        } catch {
            switch error {
            case NicknameError.empty:
                outputVaildState.value = false
                
            case NicknameError.number:
                outputNickName.value = "닉네임에 숫자는 포함할 수 없어요"
                outputVaildState.value = false

            case NicknameError.symbol:
                outputNickName.value = "닉네임에 @, #, $, % 는 포함할 수 없어요."
                outputVaildState.value = false

            case NicknameError.length:
                outputNickName.value = "2글자 이상 10글자 미만으로 설정해주세요"
                outputVaildState.value = false

            case NicknameError.cerrent:
                outputNickName.value = "현재 닉네임과 다른 닉네임으로 설정해주세요"
                outputVaildState.value = false

            default:
                break
            }
        }
    }
    
    private func saveNickname(_ value: String) {
        UserDefaultsManager.shared.userState = true
        UserDefaultsManager.shared.nickname = value
    }
    
    private func checkUserImage(_ image: String) {
        if image == "" {
            let num = Int.random(in: 1...14)
            outputUserImage.value = "profile\(num)"
        } else {
            outputUserImage.value = image
        }
    }
    

}
