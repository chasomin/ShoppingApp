//
//  SearchTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {

    let iconImageView = UIImageView()
    let label = UILabel()
    let deleteButton = UIButton()
    
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(deleteButton)

    }
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.width.height.equalTo(20)
            make.centerY.equalTo(contentView)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalTo(contentView)
            make.top.bottom.equalTo(contentView).inset(15)
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.leading.equalTo(label.snp.trailing).offset(15)
            make.top.bottom.equalTo(contentView).inset(15)
        }
        

    }
    override func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        iconImageView.image = Constants.Image.search
        iconImageView.tintColor = .white
        
        label.font = .small
        label.setLabelColor()
        
        
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(Constants.Image.delete, for: .normal)
        deleteButton.tintColor = .gray

    }
    
}

