//
//  filterButton.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/6/24.
//

import UIKit


class FilterButton: UIButton {
    let edgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)    

    override init(frame: CGRect) {
        super.init(frame: frame)

        tintColor = .clear
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        contentEdgeInsets = edgeInsets

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
