//
//  SearchResultCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    let heartButton = UIButton()
    let mallNameLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

    }
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(3.5/4)
        }
        heartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(imageView).inset(10)
            make.width.height.equalTo(30)
        }
        mallNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(mallNameLabel.snp.bottom).offset(2)
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }

    }
    func setUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
                
        mallNameLabel.textColor = .gray
        mallNameLabel.font = .small
        
        titleLabel.font = .regular
        titleLabel.numberOfLines = 2
        titleLabel.setLabelColor()
        
        priceLabel.setLabelColor()
        priceLabel.font = .largeBold
    }
}
