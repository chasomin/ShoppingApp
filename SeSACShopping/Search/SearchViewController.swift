//
//  SearchViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import SnapKit
import Toast

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
        
        
        APIManager.shard.request(text: search[indexPath.row], start: 1, sort: Constants.Sort.accuracy.rawValue) { result, error in
            if error == nil {
                guard let result else { return }
                vc.data = result
                self.navigationController?.pushViewController(vc, animated: true)
                vc.text = self.search[indexPath.row]
                vc.start = 1
                vc.navigationItem.title = self.search[indexPath.row]

                if indexPath.row != 0 {
                    let text = self.search[indexPath.row]
                    
                    self.search.remove(at: indexPath.row)
                    self.search.insert(text, at: 0)
                    UserDefaultsManager.shared.search = self.search
                    
                }
            } else {
                self.showToast(view: self.mainView.tableView, message: "오류가 발생했습니다.\n잠시후에 다시 시도해주세요")
            }
        }
        

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
            APIManager.shard.request(text: text, start: 1, sort: Constants.Sort.accuracy.rawValue) { result, error in
                if error == nil {
                    guard let result else { return }
                    vc.data = result
                    
                    if !UserDefaultsManager.shared.search.contains(text){
                        self.search.insert(text, at: 0)
                        UserDefaultsManager.shared.search = self.search
                    } else {
                        guard let index = self.search.firstIndex(of: text) else {return}
                        self.search.remove(at: index)
                        self.search.insert(text, at: 0)
                        UserDefaultsManager.shared.search = self.search
                    }
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    searchBar.text = ""


                } else {
                    if UserDefaultsManager.shared.search.isEmpty {
                        self.showToast(view: self.mainView.emptyView, message: "오류가 발생했습니다.\n잠시후에 다시 시도해주세요")
                    } else {
                        self.showToast(view: self.mainView.tableView, message: "오류가 발생했습니다.\n잠시후에 다시 시도해주세요")
                    }
                }
            }

            
            

        } else {
            if UserDefaultsManager.shared.search.isEmpty {
                self.showToast(view: self.mainView.emptyView, message: "검색어를 입력해주세요")
            } else {
                self.showToast(view: self.mainView.tableView, message: "검색어를 입력해주세요")
            }
        }
        

        print(UserDefaultsManager.shared.search)
        
        view.endEditing(true)
    }
}
