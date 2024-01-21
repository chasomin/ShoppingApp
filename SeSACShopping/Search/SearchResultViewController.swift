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
            collectionView.reloadData()
            let number = data.total.formatted()
            totalLabel.text = "\(number) 개의 검색 결과"
            start = 1

        }
    }
    let manager = APIManager()
    var text = ""
    var start = 1

    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var accuracyButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPriceButton: UIButton!
    @IBOutlet var lowPriceButton: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
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
        
    }
    
    func setButton() {
        // TODO: 버튼 타이틀 패딩..?
        designButton(accuracyButton, title: "  정확도  ")
        designButton(dateButton, title: "  날짜순  ")
        designButton(highPriceButton, title: "  가격높은순  ")
        designButton(lowPriceButton, title: "  가격낮은순  ")
        
        designActiveButton(accuracyButton, active: true)
        designActiveButton(dateButton, active: false)
        designActiveButton(highPriceButton, active: false)
        designActiveButton(lowPriceButton, active: false)

        accuracyButton.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(lowPriceButtonTapped), for: .touchUpInside)
        
        accuracyButton.isSelected = true
        dateButton.isSelected = false
        highPriceButton.isSelected = false
        lowPriceButton.isSelected = false


    }
    
    // 필터링 버튼
    func designButton(_ button: UIButton, title: String) {
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
    }
    
    func designActiveButton(_ button: UIButton, active: Bool) {
        if active {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.tintColor = .clear
        } else {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.tintColor = .clear
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
        layout.itemSize = CGSize(width: width, height: width + 100)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
    }
}


extension SearchResultViewController {
    @objc func accuracyButtonTapped() {
        designActiveButton(accuracyButton, active: true)
        designActiveButton(dateButton, active: false)
        designActiveButton(highPriceButton, active: false)
        designActiveButton(lowPriceButton, active: false)
        
        accuracyButton.isSelected = true
        dateButton.isSelected = false
        highPriceButton.isSelected = false
        lowPriceButton.isSelected = false

        
        manager.callRequest(text: text, start: start, sort: Sort.accuracy.rawValue) { shopping in
            self.data = shopping
        }
        
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    @objc func dateButtonTapped() {
        designActiveButton(accuracyButton, active: false)
        designActiveButton(dateButton, active: true)
        designActiveButton(highPriceButton, active: false)
        designActiveButton(lowPriceButton, active: false)
        
        accuracyButton.isSelected = false
        dateButton.isSelected = true
        highPriceButton.isSelected = false
        lowPriceButton.isSelected = false

        
        manager.callRequest(text: text, start: start, sort: Sort.date.rawValue) { shopping in
            self.data = shopping
        }
        
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)

    }
    @objc func highPriceButtonTapped() {
        designActiveButton(accuracyButton, active: false)
        designActiveButton(dateButton, active: false)
        designActiveButton(highPriceButton, active: true)
        designActiveButton(lowPriceButton, active: false)
        
        accuracyButton.isSelected = false
        dateButton.isSelected = false
        highPriceButton.isSelected = true
        lowPriceButton.isSelected = false

        
        manager.callRequest(text: text, start: start, sort: Sort.highPrice.rawValue) { shopping in
            self.data = shopping
        }
        
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            
    }
    
    
    @objc func lowPriceButtonTapped() {
        designActiveButton(accuracyButton, active: false)
        designActiveButton(dateButton, active: false)
        designActiveButton(highPriceButton, active: false)
        designActiveButton(lowPriceButton, active: true)
        
        accuracyButton.isSelected = false
        dateButton.isSelected = false
        highPriceButton.isSelected = false
        lowPriceButton.isSelected = true

        manager.callRequest(text: text, start: start, sort: Sort.lowPrice.rawValue) { shopping in
            self.data = shopping
        }
        
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        
        
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
        
        let filterTitle = data.items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "")
        let resultTitle = filterTitle.replacingOccurrences(of: "</b>", with: "")
        cell.titleLabel.text = resultTitle
        
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
        let filterTitle = data.items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "")
        let resultTitle = filterTitle.replacingOccurrences(of: "</b>", with: "")

        vc.navigationItem.title = resultTitle
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
                    manager.callRequest(text: text, start: start, sort: Sort.accuracy.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                } else if dateButton.isSelected {
                    manager.callRequest(text: text, start: start, sort: Sort.date.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                } else if highPriceButton.isSelected{
                    manager.callRequest(text: text, start: start, sort: Sort.highPrice.rawValue) { shopping in
                        self.data.items.append(contentsOf: shopping.items)
                    }
                } else if lowPriceButton.isSelected {
                    manager.callRequest(text: text, start: start, sort: Sort.lowPrice.rawValue) { shopping in
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
