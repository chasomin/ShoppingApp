//
//  SearchViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let manager = APIManager()
    
        
    var search = UserDefaultsManager.shared.search {
        didSet {
            tableView.reloadData()
            if !search.isEmpty {
                tableView.isHidden = false
                emptyView.isHidden = true
            } else {
                tableView.isHidden = true
                emptyView.isHidden = false
            }
        }
    }

    @IBOutlet var recentView: UIView!
    @IBOutlet var recentLable: UILabel!
    @IBOutlet var deleteAllButton: UIButton!
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    @IBOutlet var emptyImageView: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        let xib = UINib(nibName: SearchTableViewCell.id, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier:  SearchTableViewCell.id)
        
        if UserDefaultsManager.shared.search.isEmpty {
            tableView.isHidden = true
            recentView.isHidden = true
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            recentView.isHidden = false
            tableView.isHidden = false
        }
    }
    
    @objc func deleteAllButtonTapped() {
        recentView.isHidden = true
        UserDefaultsManager.shared.search.removeAll()
        search = []
    }
    @objc func deleteButtonTapped(sender: UIButton) {
        UserDefaultsManager.shared.search.remove(at: sender.tag)
        search.remove(at: sender.tag)
        if UserDefaultsManager.shared.search.isEmpty {
            recentView.isHidden = true
        }

        
    }



}


extension SearchViewController {
    func setUI() {
        view.setBackgroundColor()
        
        recentView.setBackgroundColor()
        
        navigationItem.title = "\(UserDefaultsManager.shared.nickname)님의 새싹 쇼핑"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]
        
        tableView.rowHeight = UITableView.automaticDimension
        
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barTintColor = .clear
        
        recentLable.text = "최근 검색"
        recentLable.font = .smallBold
        recentLable.setLabelColor()
        
        deleteAllButton.setTitle("모두 지우기", for: .normal)
        deleteAllButton.titleLabel?.font = .smallBold
        deleteAllButton.contentHorizontalAlignment = .trailing
        deleteAllButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        
        tableView.backgroundColor = .clear
        tableView.tableHeaderView?.backgroundColor = .clear
        
        emptyView.backgroundColor = .clear
        
        emptyImageView.image = UIImage(named: "empty")
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .largeBold
        emptyLabel.textAlignment = .center
        emptyLabel.setLabelColor()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        
        cell.deleteButton.tag = indexPath.row
        
        cell.label.text = search[indexPath.row]
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(sender:)), for: .touchUpInside)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.id) as! SearchResultViewController
        
        vc.navigationItem.title = search[indexPath.row]
            
            manager.callRequest(text: search[indexPath.row], start: 1) { shopping in
                vc.data = shopping
            }
        
        
            
            self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        recentView.isHidden = false

        // 콜렉션뷰로 이동
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.id) as! SearchResultViewController
        
        vc.navigationItem.title = searchBar.text
        
        manager.callRequest(text: searchBar.text!, start: 1) { shopping in
//            vc.total = shopping.total
            vc.data = shopping

        }
        
        
        
        search.insert(searchBar.text!, at: 0)
        UserDefaultsManager.shared.search = search
        print(UserDefaultsManager.shared.search)
        
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        searchBar.text = ""
    }
}
