//
//  SearchViewModel.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/26/24.
//

import Foundation

class SearchViewModel {
    let searchKeywords: Observable<[String]> = Observable(UserDefaultsManager.shared.search)
    
    let inputDeleteButtonTapped: Observable<Void?> = Observable(nil)
    var inputDeleteAtButtonTapped: Observable<Int?> = Observable(nil)
    var inputDidSelectRowAt: Observable<Int?> = Observable(nil)
    var inputSearchBarButtonTapped: Observable<String?> = Observable(nil)
    
    let outputSearchHistory: Observable<Bool> = Observable(false)
    let outputSearchText: Observable<String?> = Observable(nil)
    let outputShoppingData: Observable<Shopping?> = Observable(nil)
    
    init() {
        searchKeywords.bind { keywords in
            print("===",keywords)
            self.setSearchHistory(keywords)
        }
        inputDeleteButtonTapped.bind { value in
            print("delete")
            self.deleteAll(value)
        }
        inputDeleteAtButtonTapped.bind { value in
            self.deleteAt(value)
        }
        inputDidSelectRowAt.bind { value in
            print("최근검색어 검색")
            self.searchSelectRowAt(value)
        }
        inputSearchBarButtonTapped.bind { value in
            print(" !!!검색", value)
            
            self.searchBarSearchButton(value)
        }
    }
    
    private func deleteAll(_ value: Void?) {
        if value != nil {
            searchKeywords.value.removeAll()
        }
    }
    
    private func deleteAt(_ value: Int?) {
        if value != nil {
            if let value {
                searchKeywords.value.remove(at: value)
            }
        }
        
    }
    private func setSearchHistory(_ value: [String]) {
        if value.isEmpty {
            outputSearchHistory.value = true
        } else {
            outputSearchHistory.value = false
            
        }
    }
    
    
    private func searchSelectRowAt(_ index: Int?) {
        guard let index else { return }
        let text = self.searchKeywords.value[index]
        self.searchKeywords.value.remove(at: index)
        self.searchKeywords.value.insert(text, at: 0)
        outputSearchText.value = text
        
        print(self.searchKeywords.value)
    }
    
    private func searchBarSearchButton(_ text: String?) {
        guard let text else { return }
        if searchKeywords.value.first == text {
            self.searchKeywords.value.remove(at: 0)
            self.searchKeywords.value.insert(text, at: 0)
        } else {
            self.searchKeywords.value.insert(text, at: 0)
        }
        
        outputSearchText.value = text
        print("👻")
        Task {
            let result = try await APIManager.shard.request(text: text, start: 0, sort: Constants.Sort.accuracy.rawValue)
            outputShoppingData.value = result
            print("❗️", result)
        }
        
        print("!!! UserD", self.searchKeywords.value)
    }
}
