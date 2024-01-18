//
//  SearchResultCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var mallNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

}

extension SearchResultCollectionViewCell {
    func setUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        heartButton.layer.cornerRadius = heartButton.frame.width / 2
        heartButton.setTitle("", for: .normal)
        heartButton.setImage(UIImage(systemName: Image.heart), for: .normal)
        heartButton.backgroundColor = .white
        heartButton.tintColor = .black
        
        mallNameLabel.textColor = .gray
        mallNameLabel.font = .small
        
        titleLabel.font = .regular
        titleLabel.numberOfLines = 2
        priceLabel.font = .regularBold
    }
}
