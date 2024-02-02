//
//  ProfileImageCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit


class ProfileImageCollectionViewCell: UICollectionViewCell {
    let imageButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageButton.setTitle("", for: .normal)
        imageButton.circle()
        
        contentView.addSubview(imageButton)
        imageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
