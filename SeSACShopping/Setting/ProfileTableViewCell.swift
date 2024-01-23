//
//  ProfileTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNicknameLabel: UILabel!
    @IBOutlet var userLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}

extension ProfileTableViewCell {
    
    func setUI() {
        userImageView.circleBorder()
        
        userNicknameLabel.font = .largeBold
        userNicknameLabel.setLabelColor()
        userNicknameLabel.numberOfLines = 1
        
        setLikeButton()

        selectionStyle = .none
        
        userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
        
        userNicknameLabel.text = UserDefaultsManager.shared.nickname
                
    }
    
    func setLikeButton() {
        userLikeLabel.font = .regularBold
        userLikeLabel.setLabelColor()
        userLikeLabel.numberOfLines = 1
        userLikeLabel.attributedText = UserDefaultsManager.shared.likeLabel
    }
}
