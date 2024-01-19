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
        setBackgroundColor()
        
        userImageView.circleBorder()
        
        userNicknameLabel.font = .largeBold
        userNicknameLabel.setLabelColor()
        
        userLikeLabel.font = .regularBold
        userLikeLabel.setLabelColor()

        selectionStyle = .none
    }
    
    func configureCell() {
        userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
        userNicknameLabel.text = UserDefaultsManager.shared.nickname
        userLikeLabel.text = UserDefaultsManager.shared.likeLabel
        
    }
}
