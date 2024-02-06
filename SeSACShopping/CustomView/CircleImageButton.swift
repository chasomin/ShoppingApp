//
//  CircleImageButton.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/6/24.
//

import UIKit

class CircleImageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    func configureView() {
        self.layer.borderColor = UIColor.point.cgColor
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
