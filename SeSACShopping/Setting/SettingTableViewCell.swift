//
//  SettingTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        textLabel?.font = .small
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
