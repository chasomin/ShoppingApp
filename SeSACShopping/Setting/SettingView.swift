//
//  SettingView.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/1/24.
//

import UIKit
import SnapKit

class SettingView: BaseView {
    let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    

    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
    }
}
