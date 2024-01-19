//
//  UIImage+Extension.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

extension UIImageView {
    func circleBorder() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        self.layer.borderColor = UIColor.point.cgColor
        self.layer.borderWidth = 5
    }
    
    func circle() {
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
}
