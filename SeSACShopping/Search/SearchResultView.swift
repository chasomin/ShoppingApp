//
//  SearchResultView.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/1/24.
//

import UIKit
import SnapKit

class SearchResultView: BaseView {
    

    let totalLabel = UILabel()
    let accuracyButton = FilterButton()
    let dateButton = FilterButton()
    let highPriceButton = FilterButton()
    let lowPriceButton = FilterButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionView())
    let emptyView = UIView()
    let emptyImageView = UIImageView()
    let emptyLabel = UILabel()
    
    lazy var buttons: [UIButton] = [accuracyButton, dateButton, highPriceButton, lowPriceButton]


    override func configureHierarchy() {
        addSubview(totalLabel)
        
        addSubview(accuracyButton)
        addSubview(dateButton)
        addSubview(highPriceButton)
        addSubview(lowPriceButton)
        
        addSubview(emptyView)
        emptyView.addSubview(emptyImageView)
        emptyView.addSubview(emptyLabel)

        addSubview(collectionView)
    }
    
    override func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        accuracyButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(10)
        }
        highPriceButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)

        }
        lowPriceButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
            make.leading.equalTo(highPriceButton.snp.trailing).offset(10)
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(70)
            make.height.equalTo(emptyImageView.snp.width)
        }
        emptyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(emptyImageView.snp.bottom)
            make.bottom.greaterThanOrEqualToSuperview().inset(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(emptyView)
        }
    }
    
    override func configureView() {
        
        totalLabel.font = .regularBold
        totalLabel.textColor = .point
        
        accuracyButton.setTitle("정확도", for: .normal)
        dateButton.setTitle("날짜순", for: .normal)
        highPriceButton.setTitle("가격높은순", for: .normal)
        lowPriceButton.setTitle("가격낮은순", for: .normal)

        emptyView.setBackgroundColor()
        
        emptyLabel.text = "검색어에 맞는 상품이 없어요"
        emptyLabel.font = .largeBold
        emptyLabel.textAlignment = .center
        emptyLabel.setLabelColor()

        emptyImageView.image = Constants.Image.empty
        emptyImageView.contentMode = .scaleAspectFit
        

    }
    
    static func setCollectionView() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width + 70)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        return layout
    }
    
    // 상태에 따른 필터링 버튼 디자인 차이
    func designActiveButton(_ button: UIButton, title: String) {
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        
    }
    func designInactiveButton() {
        for sender in buttons {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
        }
    }

}
