//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
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
        imageView.image = UIImage(named: UserDefaultsManager.shared.image)
        
        navigationController?.setNavigationBar()

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
        
        Constants.ProfileImages.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        let image = UIImage(named: Constants.ProfileImages.profileImageList[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.imageButton.setImage(image, for: .normal)
        
        cell.imageButton.tag = indexPath.item + 1
        
        if UserDefaultsManager.shared.image == "profile\(cell.imageButton.tag)" {
            cell.imageButton.circleBorder()
        } else {
            cell.imageButton.circle()
        }
            
        cell.imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func imageButtonTapped(sender: UIButton) {
        UserDefaultsManager.shared.image = "profile\(sender.tag)"
        collectionView.reloadData()
        imageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }
    

}
