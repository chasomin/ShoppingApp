//
//  SearchResultViewModel.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/26/24.
//

import Foundation


class SearchResultViewModel {
    let data: Observable<Shopping> = Observable(Shopping(total: 0, start: 0, display: 0, items: []))
    
    var text = Observable("")
    var start = Observable(1)

    let inputSortButton = Observable(0)
    let inputSetViewDidLoad: Observable<Void?> = Observable(nil)
    let inputPagenation: Observable<IndexPath?> = Observable(nil)
    let currentSortType: Observable<Constants.Sort?> = Observable(nil)
    
    let outputReqeustValue: Observable<Shopping?> = Observable(nil)
    let outputRequestError: Observable<RequestError?> = Observable(nil)
    let outputProductNum = Observable("")
    let outputTopPage: Observable<Void?> = Observable(nil)
    
    init() {

        inputSortButton.bind { value in
            guard let currentSort = self.currentSortType.value else { return }
            let seleteSortType = Constants.Sort.allCases[value]
            self.data.value = .init(total: 0, start: 0, display: 0, items: [])
            if currentSort != seleteSortType {
                self.callRequest(text: self.text.value, sort: .allCases[value], start: self.start.value)
            }
        }
        inputSetViewDidLoad.bind { _ in
            self.callRequest(text: self.text.value, sort: .accuracy, start: 1)
            
        }
        
        inputPagenation.bind { item in
            guard let item else { return }
            self.setPagenation(item)
        }
    }
    private func callRequest(text: String, sort: Constants.Sort, start: Int) {
            currentSortType.value = sort

            APIManager.shard.request(text: text, start: start, sort: sort.rawValue) { [weak self] result, error in
                guard let self else { return }
                if error == nil {
                    guard let result else { return }
                    if result.items.isEmpty {
                        return
                    }
                    data.value.total = result.total
                    setFetch()
                    data.value.items.append(contentsOf: result.items)
                    print("~~~~\(currentSortType),\(sort)")
                    self.outputTopPage.value = ()

                } else {
                    outputRequestError.value = nil
                }
            }
        
    }
    
    private func setFetch() {
        let number = data.value.total.formatted()
        outputProductNum.value = "\(number) 개의 검색 결과"
    }
    
    private func setPagenation(_ item: IndexPath) {
        if data.value.items.count - 4 == item.row && data.value.items.count != data.value.total {
            start.value += 30
            guard let currentType = currentSortType.value else { return }
            callRequest(text: text.value, sort: currentType, start: start.value)
            
        }
        
    }
}
