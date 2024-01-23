//
//  UIButton+Extension.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

extension UIButton {
    
    func setPointButton() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .point
        self.tintColor = .text
        self.titleLabel?.font = .largeBold
    }
    
    func circle() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor

    }
    
    func circleBorder() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.point.cgColor
        self.layer.borderWidth = 5
    }
    
    func heartButton() {
        circle()
        self.setTitle("", for: .normal)
        self.setImage(UIImage(systemName: Constants.Image.heart), for: .normal)
        self.backgroundColor = .white
        self.tintColor = .black
    }
    
    func heartFillButton() {
        circle()
        self.setTitle("", for: .normal)
        self.setImage(UIImage(systemName: Constants.Image.heartFill), for: .normal)
        self.backgroundColor = .white
        self.tintColor = .black
    }
}
