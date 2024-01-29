//
//  PointBorderUserImageView.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/29/24.
//

import UIKit

class PointBorderUserImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
//        DispatchQueue.main.async {
//            self.layer.cornerRadius = self.frame.width / 2
//        }
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.point.cgColor
        self.layer.borderWidth = 5
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
