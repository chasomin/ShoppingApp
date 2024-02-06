//
//  ProfileTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    let userImageView = PointBorderUserImageView(frame: .zero)
    let userNicknameLabel = UILabel()
    let userLikeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init")
        configureHierarchy()
        setupConstraints()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileTableViewCell {
    
    func configureCell() {
        userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }

    func configureHierarchy() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNicknameLabel)
        contentView.addSubview(userLikeLabel)
    }
    
    func setUI() {
        userNicknameLabel.font = .largeBold
        userNicknameLabel.setLabelColor()
        userNicknameLabel.numberOfLines = 1
        userNicknameLabel.textAlignment = .left
        
        setLikeButton()

        selectionStyle = .none
        
        userNicknameLabel.text = UserDefaultsManager.shared.nickname
                
    }
    
    func setLikeButton() {
        userLikeLabel.font = .regularBold
        userLikeLabel.textAlignment = .left
        userLikeLabel.setLabelColor()
        userLikeLabel.numberOfLines = 1
        userLikeLabel.attributedText = UserDefaultsManager.shared.likeLabel
    }
    
    func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(60)
            make.verticalEdges.equalToSuperview().inset(20)
        }
        
        userNicknameLabel.snp.makeConstraints { make in
            make.trailing.greaterThanOrEqualToSuperview().inset(30)
            make.top.equalToSuperview().inset(25)
            make.leading.equalTo(userImageView.snp.trailing).offset(30)
        }
        userLikeLabel.snp.makeConstraints { make in
            make.trailing.greaterThanOrEqualToSuperview().inset(30)
            make.top.equalTo(userNicknameLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(25)
            make.leading.equalTo(userImageView.snp.trailing).offset(30)
        }
    }
}
