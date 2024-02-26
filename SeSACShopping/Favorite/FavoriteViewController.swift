//
//  FavoriteViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/18/24.
//

import UIKit
import RealmSwift

final class FavoriteViewController: UIViewController {
    let mainView = FavoriteView()
    
    let repository = FavoriteTableRepository()
    var favoriteDataList: Results<FavoriteTable>!
//    var favoriteData = FavoriteTable(product: "", title: "", link: "", image: "", lprice: "", mallName: "")
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "좋아요"

        let collectionView = mainView.collectionView
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteDataList = repository.read()
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        repository.deleteItem(favoriteDataList[sender.tag])
    }


}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
//        cell.configureCell(index: indexPath.row, data: nil, favoriteData: favoriteDataList)
        
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        cell.heartButton.tag = indexPath.item
        return cell
    }
    
    
}
