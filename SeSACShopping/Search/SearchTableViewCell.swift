//
//  SearchTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    let iconImageView = UIImageView()
    let label = UILabel()
    let deleteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        setUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SearchTableViewCell {
    
    func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(deleteButton)
    }

    func setUI() {
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
    
    func setupConstraints() {
        
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
}
