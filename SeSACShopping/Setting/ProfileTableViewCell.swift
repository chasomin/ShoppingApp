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
//        setBackgroundColor()
        
//        backgroundColor = .darkGray
        userImageView.circleBorder()
        
        userNicknameLabel.font = .largeBold
        userNicknameLabel.setLabelColor()
        userNicknameLabel.numberOfLines = 1
        
        userLikeLabel.font = .regularBold
        userLikeLabel.setLabelColor()
        userLikeLabel.text = UserDefaultsManager.shared.likeLabel
        userLikeLabel.numberOfLines = 1

        selectionStyle = .none
        
        userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
        userNicknameLabel.text = UserDefaultsManager.shared.nickname
        
        let fullText = userLikeLabel.text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: "\(UserDefaultsManager.shared.like.count)개의 상품")
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.point, range: range)
        userLikeLabel.attributedText = attributedString


        
    }
    
//    func configureCell() {
//        
//    }
}
