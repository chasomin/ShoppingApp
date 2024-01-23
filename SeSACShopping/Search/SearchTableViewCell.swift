//
//  SearchTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
}

extension SearchTableViewCell {
    func setUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        iconImageView.image = UIImage(systemName: Constants.Image.search)
        iconImageView.tintColor = .white
        
        label.font = .small
        label.setLabelColor()
        
        
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(systemName: Constants.Image.delete, withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)), for: .normal)
        deleteButton.tintColor = .gray
        
    }
}
