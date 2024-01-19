//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    let imageList: [String] = ["profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "profile9", "profile10", "profile11","profile12","profile13","profile14"]
    
    var image = ""  // 이전 뷰에서 받아온 이미지
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xib = UINib(nibName: ProfileImageCollectionViewCell.id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)

    }
    


}



extension ProfileImageViewController {
    func setUI() {
        imageView.circleBorder()
        imageView.image = UIImage(named: image)
    }
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width
        let spacing: CGFloat = 10
        let itemWidth = (width - spacing * 5 - 20) / 4
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        let image = UIImage(named: imageList[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.imageButton.setImage(image, for: .normal)
        return cell
    }
    
    
}
