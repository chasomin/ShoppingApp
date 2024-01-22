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
                
        mallNameLabel.textColor = .gray
        mallNameLabel.font = .small
        
        titleLabel.font = .regular
        titleLabel.numberOfLines = 2
        titleLabel.setLabelColor()
        
        priceLabel.setLabelColor()
        priceLabel.font = .largeBold
    }
}
