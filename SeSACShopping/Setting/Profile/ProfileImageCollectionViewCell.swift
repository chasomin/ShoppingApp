//
//  ProfileImageCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit


class ProfileImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageButton: UIButton!
    var state: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageButton.setTitle("", for: .normal)
        imageButton.circle()
    }
    

}
