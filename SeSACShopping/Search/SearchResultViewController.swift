//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import Kingfisher

class SearchResultViewController: UIViewController {        

    let mainView = SearchResultView()
    
    override func loadView() {
        view = mainView
    }
    var data = Shopping(total: 0, start: 0, display: 0, items: []) {
        didSet {
            if mainView.collectionView != nil {
                mainView.collectionView.reloadData()
            }
            let number = data.total.formatted()
            mainView.totalLabel.text = "\(number) 개의 검색 결과"
            start = 1
            if data.total == 0 {
                mainView.collectionView.isHidden = true
                mainView.emptyView.isHidden = false
            } else {
                mainView.collectionView.isHidden = false
                mainView.emptyView.isHidden = true
            }
        }
    }
    var text = ""
    var start = 1
    lazy var number = data.total.formatted()

    lazy var seletButton = mainView.accuracyButton

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBar()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)

        mainView.totalLabel.text = "\(number) 개의 검색 결과"

        if data.total == 0 {
            mainView.collectionView.isHidden = true
        } else {
            mainView.collectionView.isHidden = false
        }
        setButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData() // 좋아요 버튼 동기화

    }


}


extension SearchResultViewController {
    func setButton() {
        for i in 0..<mainView.buttons.count {
            mainView.buttons[i].tag = i
        }
        
        filterButtonTapped(mainView.accuracyButton)
        
        mainView.accuracyButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        mainView.highPriceButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        mainView.lowPriceButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
        
}


// 필터링 버튼들 클릭 시 수행 할 액션
extension SearchResultViewController {
    @objc func filterButtonTapped(_ sender: FilterButton) {
        mainView.designInactiveButton()
        mainView.designActiveButton(sender, title: Constants.Button.FilterButton.allCases[sender.tag].rawValue)
        seletButton = sender
        
        request(sort: .allCases[sender.tag]) { result in
            self.data = result
        }
        
        if data.total != 0 {
            self.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    func request(sort: Constants.Sort, completionHandler: @escaping (Shopping) -> Void) {
        APIManager.shard.request(text: text, start: start, sort: sort.rawValue) { result, error in
            if error == nil {
                guard let result else { return }
                completionHandler(result)
            } else {
                self.showAlert(title: "오류가 발생했습니다!", message: error?.rawValue ?? "알 수 없는 오류가 발생했습니다.\n잠시후에 다시 시도해주세요", buttonTitle: "확인") {
                }
                self.showToast(view: self.mainView.collectionView, message: "오류가 발생했습니다.\n잠시후에 다시 시도해주세요")
                
            }
        }
    }
}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
        
        cell.imageView.kf.setImage(with: URL(string: data.items[indexPath.item].image))
        
        cell.mallNameLabel.text = data.items[indexPath.item].mallName
        
        cell.titleLabel.text = data.items[indexPath.item].titleFilter
        
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped(sender:)), for: .touchUpInside)
        
        if UserDefaultsManager.shared.like.contains(data.items[indexPath.row].productId) {
            cell.heartButton.heartFillButton()
        } else {
            cell.heartButton.heartButton()
        }

        cell.priceLabel.text = Int(data.items[indexPath.item].lprice)?.formatted()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = "https://msearch.shopping.naver.com/product/\(data.items[indexPath.item].productId)"
        
        let vc = ItemDetailViewController()
        
        vc.urlString = url

        vc.navigationItem.title = data.items[indexPath.item].titleFilter
        vc.productId = data.items[indexPath.item].productId
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func heartButtonTapped(sender: UIButton) {
        if UserDefaultsManager.shared.like.contains(data.items[sender.tag].productId) {
            guard let index = UserDefaultsManager.shared.like.firstIndex(of: data.items[sender.tag].productId) else { return }
            UserDefaultsManager.shared.like.remove(at: index)
        } else {
            UserDefaultsManager.shared.like.append(data.items[sender.tag].productId)
        }
        
        print(UserDefaultsManager.shared.like.count)
        mainView.collectionView.reloadData()
    }
}



extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        
        for item in indexPaths {
            if data.items.count - 7 == item.row && data.items.count != data.total {
                start += 30
                switch seletButton {
                case mainView.accuracyButton:
                    print("")
                    request(sort: .accuracy) { result in
                        self.data.items.append(contentsOf: result.items)
                    }

                case mainView.dateButton:
                    print("")
                    request(sort: .date) { result in
                        self.data.items.append(contentsOf: result.items)
                    }

                case mainView.highPriceButton:
                    request(sort: .highPrice) { result in
                        self.data.items.append(contentsOf: result.items)
                    }
                    
                case mainView.lowPriceButton:
                    request(sort: .lowPrice) { result in
                        self.data.items.append(contentsOf: result.items)
                    }

                default:
                    break
                }
            }
                
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 동작함!
}
