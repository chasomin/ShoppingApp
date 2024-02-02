//
//  SearchViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
        
    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
    }
        
    var search = UserDefaultsManager.shared.search {
        didSet {
            mainView.tableView.reloadData()
            if !search.isEmpty {
                mainView.tableView.isHidden = false
                mainView.emptyView.isHidden = true
                mainView.recentView.isHidden = false
            } else {
                mainView.tableView.isHidden = true
                mainView.emptyView.isHidden = false
                mainView.recentView.isHidden = true

            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self

        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        setHiddenView()
        navigationItem.title = "\(UserDefaultsManager.shared.nickname)님의 새싹 쇼핑"
        
        mainView.deleteAllButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        mainView.panGesture.addTarget(self, action: #selector(keyboardDismiss))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(UserDefaultsManager.shared.search)
    }
    
    @objc func deleteAllButtonTapped() {
        mainView.recentView.isHidden = true
        UserDefaultsManager.shared.search.removeAll()
        search = []
    }
    @objc func deleteButtonTapped(sender: UIButton) {
        UserDefaultsManager.shared.search.remove(at: sender.tag)
        search.remove(at: sender.tag)
        if UserDefaultsManager.shared.search.isEmpty {
            mainView.recentView.isHidden = true
        }
    }
    
    @objc func keyboardDismiss(_ sender: UIPanGestureRecognizer) {
        view.endEditing(true)
    }
}


extension SearchViewController {
    
    func setHiddenView() {
        if UserDefaultsManager.shared.search.isEmpty {
            mainView.tableView.isHidden = true
            mainView.recentView.isHidden = true
            mainView.emptyView.isHidden = false
        } else {
            mainView.emptyView.isHidden = true
            mainView.recentView.isHidden = false
            mainView.tableView.isHidden = false
        }
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
        
        let vc = SearchResultViewController()
        
        vc.navigationItem.title = search[indexPath.row]
        
        APIManager.shard.callRequest(text: search[indexPath.row], start: 1, sort: Constants.Sort.accuracy.rawValue) { shopping in
            vc.data = shopping
        }
        vc.text = search[indexPath.row]
        vc.start = 1

        
        if indexPath.row != 0 {
            let text = search[indexPath.row]
            
            search.remove(at: indexPath.row)
            search.insert(text, at: 0)
            UserDefaultsManager.shared.search = search
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!.lowercased().trimmingCharacters(in: .whitespaces)

        
        let vc = SearchResultViewController()
        
        vc.navigationItem.title = text
        vc.text = text
        vc.start = 1

        if text != "" {
            APIManager.shard.callRequest(text: text, start: 1, sort: Constants.Sort.accuracy.rawValue) { shopping in
                vc.data = shopping
            }
            
            
            if !UserDefaultsManager.shared.search.contains(text){
                search.insert(text, at: 0)
                UserDefaultsManager.shared.search = search
            } else {
                guard let index = search.firstIndex(of: text) else {return}
                search.remove(at: index)
                search.insert(text, at: 0)
                UserDefaultsManager.shared.search = search
            }
            
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        searchBar.text = ""

        print(UserDefaultsManager.shared.search)
        
        view.endEditing(true)
    }
}
