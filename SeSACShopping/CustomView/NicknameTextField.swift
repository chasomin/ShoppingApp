//
//  NicknameTextField.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/29/24.
//

import UIKit

class NicknameTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        borderStyle = .none
//        clipsToBounds = true
        textColor = .text


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
