//
//  SearchView.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/1/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    let recentView = UIView()
    let recentLable = UILabel()
    let deleteAllButton = UIButton()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let emptyView = UIView()
    let emptyImageView = UIImageView()
    let emptyLabel = UILabel()
    let panGesture = UIPanGestureRecognizer()

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(recentView)
        recentView.addSubview(recentLable)
        recentView.addSubview(deleteAllButton)
        addSubview(emptyView)
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(emptyLabel)
        addSubview(tableView)
        addGestureRecognizer(panGesture)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        recentView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
        
        recentLable.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(recentView.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(330)
            make.top.greaterThanOrEqualToSuperview().inset(50)
        }
        emptyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(emptyImageView.snp.bottom)
            make.bottom.equalToSuperview().inset(200)
            make.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentView.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()

        }
    }
    
    override func configureView() {
        recentView.setBackgroundColor()
        
        
        tableView.rowHeight = UITableView.automaticDimension
        
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barTintColor = .clear
        
        recentLable.text = "최근 검색"
        recentLable.font = .smallBold
        recentLable.setLabelColor()
        
        deleteAllButton.setTitle("모두 지우기", for: .normal)
        deleteAllButton.titleLabel?.font = .smallBold
        deleteAllButton.contentHorizontalAlignment = .trailing
        deleteAllButton.setTitleColor(.point, for: .normal)
        
        tableView.backgroundColor = .clear
        tableView.tableHeaderView?.backgroundColor = .clear
        
        emptyView.backgroundColor = .clear
        
        emptyImageView.image = Constants.Image.empty
        emptyImageView.contentMode = .scaleAspectFit

        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .largeBold
        emptyLabel.textAlignment = .center
        emptyLabel.setLabelColor()
    }
    
}
