//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import Kingfisher

class SearchResultViewController: UIViewController {        

    var data = Shopping(total: 0, start: 0, display: 0, items: []) {
        didSet {
            if collectionView != nil {
                collectionView.reloadData()
            }
            let number = data.total.formatted()
            totalLabel.text = "\(number) 개의 검색 결과"
            start = 1
            if data.total == 0 {
                collectionView.isHidden = true
                emptyView.isHidden = false
            } else {
                collectionView.isHidden = false
                emptyView.isHidden = true

            }


        }
    }
    var text = ""
    var start = 1

    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var accuracyButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPriceButton: UIButton!
    @IBOutlet var lowPriceButton: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet var emptyImageView: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    lazy var buttons: [UIButton] = [accuracyButton, dateButton, highPriceButton, lowPriceButton]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setButton()
        setCollectionView()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData() // 좋아요 버튼 동기화

    }


}


extension SearchResultViewController {
    func setUI() {
        navigationController?.setNavigationBar()
        
        totalLabel.font = .regularBold
        totalLabel.textColor = .point
        let number = data.total.formatted()
        totalLabel.text = "\(number) 개의 검색 결과"
        
        emptyView.setBackgroundColor()
        
        emptyLabel.text = "검색어에 맞는 상품이 없어요"
        emptyLabel.font = .largeBold
        emptyLabel.textAlignment = .center
        emptyLabel.setLabelColor()

        emptyImageView.image = Constants.Image.empty
        emptyImageView.contentMode = .scaleAspectFit
        
        if data.total == 0 {
            collectionView.isHidden = true
        } else {
            collectionView.isHidden = false
        }
    }
    
    func setButton() {
        for i in 0..<buttons.count {
            buttons[i].tag = i
        }
        
        filterButtonTapped(accuracyButton)
        
        accuracyButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
    }
        
    // 상태에 따른 필터링 버튼 디자인 차이
    func designActiveButton(_ button: UIButton, active: Bool, title: String) {
        if active {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.tintColor = .clear
        } else {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.tintColor = .clear
        }
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
        let edgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.contentEdgeInsets = edgeInsets
        
    }
    
    func filterButtonInactive() {
        for i in 0..<Constants.Button.FilterButton.allCases.count {
            designActiveButton(buttons[i], active: false, title: Constants.Button.FilterButton.allCases[i].rawValue)
            buttons[i].isSelected = false
        }
    }
    
    func setCollectionView() {
        let xib = UINib(nibName: SearchResultCollectionViewCell.id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width + 70)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
    }
}


// 필터링 버튼들 클릭 시 수행 할 액션
extension SearchResultViewController {
    @objc func filterButtonTapped(_ sender: UIButton) {
        filterButtonInactive()
        
        designActiveButton(sender, active: true, title: Constants.Button.FilterButton.allCases[sender.tag].rawValue)
        sender.isSelected = true
        print(sender)

        APIManager.shard.callRequest(text: text, start: start, sort: Constants.Sort.allCases[sender.tag].rawValue) { shopping in
            self.data = shopping
        }
        
        if data.total != 0 {
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
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
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ItemDetailViewController.id) as! ItemDetailViewController
        
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
        collectionView.reloadData()
    }
}



extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        
        for item in indexPaths {
            if data.items.count - 7 == item.row && data.items.count != data.total {
                start += 30
                if accuracyButton.isSelected {
                    APIManager.shard.callRequest(text: text, start: start, sort: Constants.Sort.accuracy.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                } else if dateButton.isSelected {
                    APIManager.shard.callRequest(text: text, start: start, sort: Constants.Sort.date.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                } else if highPriceButton.isSelected{
                    APIManager.shard.callRequest(text: text, start: start, sort: Constants.Sort.highPrice.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                } else if lowPriceButton.isSelected {
                    APIManager.shard.callRequest(text: text, start: start, sort: Constants.Sort.lowPrice.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                }
            }
                
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 동작함!
}
