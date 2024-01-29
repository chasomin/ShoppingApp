//
//  PointCornerRadiusButton.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/29/24.
//

import UIKit

class PointCornerRadiusButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        layer.cornerRadius = 10
        backgroundColor = .point
        tintColor = .text
        titleLabel?.font = .largeBold
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
