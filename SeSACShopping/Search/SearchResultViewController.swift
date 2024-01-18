//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import Kingfisher

class SearchResultViewController: UIViewController {
    var data = Shopping(total: 0, start: 0, display: 0, items: [])

    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var accuracyButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPriceButton: UIButton!
    @IBOutlet var lowPriceButton: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
        collectionView.reloadData()
        print(data.total)
    }



}


extension SearchResultViewController {
    func setUI() {
        totalLabel.font = .regularBold
        totalLabel.textColor = .point
        totalLabel.text = "\(data.total) 개의 검색 결과"
        
        // TODO: 버튼 타이틀 패딩..?
        designButton(accuracyButton, active: true, title: "  정확도  ")
        designButton(dateButton, active: false, title: "  날짜순  ")
        designButton(highPriceButton, active: false, title: "  가격높은순  ")
        designButton(lowPriceButton, active: false, title: "  가격낮은순  ")
        
    }
    
    func designButton(_ button: UIButton, active: Bool, title: String) {
        if active {
            button.backgroundColor = .white
            button.tintColor = .black
        } else {
            button.tintColor = .white
        }
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: .normal)
    }
    
    func setCollectionView() {
        let xib = UINib(nibName: SearchResultCollectionViewCell.id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(data.items.count)
        return data.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
        
        cell.imageView.kf.setImage(with: URL(string: data.items[indexPath.item].image))
        
        cell.mallNameLabel.text = data.items[indexPath.item].mallName
        
        let filterTitle = data.items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "")
        let resultTitle = filterTitle.replacingOccurrences(of: "</b>", with: "")
        cell.titleLabel.text = resultTitle
        
        
        
        

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
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
