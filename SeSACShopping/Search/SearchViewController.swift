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
    let viewModel = SearchViewModel()
    
    override func loadView() {
        view = mainView
    }
        
//    var search = UserDefaultsManager.shared.search {
//        didSet {
//            mainView.tableView.reloadData()
//            if !search.isEmpty {
//                mainView.tableView.isHidden = false
//                mainView.emptyView.isHidden = true
//                mainView.recentView.isHidden = false
//            } else {
//                mainView.tableView.isHidden = true
//                mainView.emptyView.isHidden = false
//                mainView.recentView.isHidden = true
//
//            }
//            
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self

        mainView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        navigationItem.title = "\(UserDefaultsManager.shared.nickname)님의 새싹 쇼핑"
        
        mainView.deleteAllButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        mainView.panGesture.addTarget(self, action: #selector(keyboardDismiss))
                
        viewModel.outputSearchHistory.bind { value in
            if value {
                self.mainView.tableView.isHidden = true
                self.mainView.recentView.isHidden = true
                self.mainView.emptyView.isHidden = false
            } else {
                self.mainView.emptyView.isHidden = true
                self.mainView.recentView.isHidden = false
                self.mainView.tableView.isHidden = false
            }
        }
        
        viewModel.outputSearchText.bind { (value) in
            guard let value else { return }
            print("화면 이동")
            let vc = SearchResultViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.viewModel.text.value = value
//            vc.start = 1
            vc.navigationItem.title = value


        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
        print(UserDefaultsManager.shared.search)
    }
    
    @objc func deleteAllButtonTapped() {
        viewModel.inputDeleteButtonTapped.value = ()
    }
    
    @objc func deleteButtonTapped(sender: UIButton) {
        viewModel.inputDeleteAtButtonTapped.value = sender.tag
    }
    
    @objc func keyboardDismiss(_ sender: UIPanGestureRecognizer) {
        view.endEditing(true)
    }
}



extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchKeywords.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        
        cell.deleteButton.tag = indexPath.row
        cell.label.text = viewModel.searchKeywords.value[indexPath.row]
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(sender:)), for: .touchUpInside)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputDidSelectRowAt.value = indexPath.row
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let text = searchBar.text!.lowercased().trimmingCharacters(in: .whitespaces)
        viewModel.inputSearchBarButtonTapped.value = text.lowercased().trimmingCharacters(in: .whitespaces)
        print("!!!",text.lowercased().trimmingCharacters(in: .whitespaces))
//        vc.navigationItem.title = text
//        vc.text = text
//        vc.start = 1


        

        print(UserDefaultsManager.shared.search)
        
        view.endEditing(true)
    }
}
