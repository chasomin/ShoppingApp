//
//  ProfileImageCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit


class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    let imageButton = CircleImageButton()
    
    
    override func configureHierarchy() {
        contentView.addSubview(imageButton)
    }
    
    override func configureLayout() {
        imageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        imageButton.setTitle("", for: .normal)
    }
}
