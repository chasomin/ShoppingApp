//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import Kingfisher
import RealmSwift

class SearchResultViewController: UIViewController {        

    let mainView = SearchResultView()
    let viewModel = SearchResultViewModel()
    override func loadView() {
        view = mainView
    }

    var favoriteDataList: Results<FavoriteTable>!
    var favoriteData: FavoriteTable = FavoriteTable(product: "", title: "", link: "", image: "", lprice: "", mallName: "")
    let repository = FavoriteTableRepository()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBar()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
        setButton()
        
        viewModel.outputRequestError.bind { error in
            guard error != nil else { return }
            self.showToast(view: self.mainView.collectionView, message: "오류가 발생했습니다.\n잠시후에 다시 시도해주세요")
        }
        
        viewModel.data.bind { data in
            self.mainView.collectionView.reloadData()
            if data.total == 0 {
                self.mainView.collectionView.isHidden = true
                self.mainView.emptyView.isHidden = false
            } else {
                self.mainView.collectionView.isHidden = false
                self.mainView.emptyView.isHidden = true

            }
        }
        viewModel.outputProductNum.bind { value in
            self.mainView.totalLabel.text = value
        }
        viewModel.inputSetViewDidLoad.value = ()
        

        viewModel.outputTopPage.bind { value in
            guard let value else { return }
            self.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.collectionView.reloadData() // 좋아요 버튼 동기화
        favoriteDataList = repository.read()
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
        viewModel.inputSortButton.value = sender.tag
    }
}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.value.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
       
        //test
        cell.configureCell(index: indexPath.item, data: viewModel.data.value, favoriteData: favoriteDataList[0])
        
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = "https://msearch.shopping.naver.com/product/\(viewModel.data.value.items[indexPath.item].productId)"
        
        let vc = ItemDetailViewController()
        
        vc.urlString = url

        vc.navigationItem.title = viewModel.data.value.items[indexPath.item].titleFilter
        vc.productId = viewModel.data.value.items[indexPath.item].productId
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // TODO: 좋아요 버튼 realm 저장 
    @objc func heartButtonTapped(sender: UIButton) {
        let item = viewModel.data.value.items[sender.tag]
        if favoriteDataList.isEmpty {
            repository.createItem(FavoriteTable(product: item.productId, title: item.titleFilter, link: item.link, image: item.image, lprice: item.lprice, mallName: item.mallName))
        } else {
//            
//            favoriteDataList.forEach {
//                if $0.product == data.items[sender.tag].productId {
//                    repository.deleteItem(favoriteDataList[sender.tag])
//                } else {
//                    repository.createItem(FavoriteTable(product: item.productId, title: item.titleFilter, link: item.link, image: item.image, lprice: item.lprice, mallName: item.mallName))
//                }
//            }
            favoriteData = FavoriteTable(product: item.productId, title: item.titleFilter, link: item.link, image: item.image, lprice: item.lprice, mallName: item.mallName)
            if favoriteDataList.contains(favoriteData) {
                repository.deleteItem(favoriteData)
            } else {
                repository.createItem(favoriteData)
            }
        }
        
//        if UserDefaultsManager.shared.like.contains(data.items[sender.tag].productId) {
//            guard let index = UserDefaultsManager.shared.like.firstIndex(of: data.items[sender.tag].productId) else { return }
//            UserDefaultsManager.shared.like.remove(at: index)
//        } else {
//            UserDefaultsManager.shared.like.append(data.items[sender.tag].productId)
//        }
//
//        print(UserDefaultsManager.shared.like.count)
        mainView.collectionView.reloadData()
    }
}



extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        
        for item in indexPaths {
            viewModel.inputPagenation.value = item
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 동작함!
}
