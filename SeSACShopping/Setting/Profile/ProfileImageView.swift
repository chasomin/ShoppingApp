//
//  ProfileImageView.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/1/24.
//

import UIKit
import SnapKit

class ProfileImageView: BaseView {
    let imageView = PointBorderUserImageView(frame: .zero)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionView())
    

    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(collectionView)
    }
    override func configureLayout() {
        imageView.image = UIImage(named: UserDefaultsManager.shared.image)        
    }
    override func configureView() {
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    static func setCollectionView() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width
        let spacing: CGFloat = 10
        let itemWidth = (width - spacing * 5 - 20) / 4
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        
        return layout
    }

}
