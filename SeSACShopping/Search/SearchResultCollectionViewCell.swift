//
//  SearchResultCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: BaseCollectionViewCell {

    let imageView = UIImageView()
    let heartButton = UIButton()
    let mallNameLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

    }
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(3.5/4)
        }
        heartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(imageView).inset(10)
            make.width.height.equalTo(30)
        }
        mallNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(mallNameLabel.snp.bottom).offset(2)
        }
        priceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }

    }
    
    override func configureView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
                
        mallNameLabel.textColor = .gray
        mallNameLabel.font = .small
        mallNameLabel.numberOfLines = 1
        
        titleLabel.font = .regular
        titleLabel.numberOfLines = 2
        titleLabel.setLabelColor()
        
        
        priceLabel.setLabelColor()
        priceLabel.font = .largeBold
    }
}
