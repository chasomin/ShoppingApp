//
//  EditUserImageView.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/29/24.
//

import UIKit

class EditUserImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        image = Constants.Image.camera
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
