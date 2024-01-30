//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
    let imageView = PointBorderUserImageView(frame: .zero)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionView())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setUI()
        setupConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xib = UINib(nibName: ProfileImageCollectionViewCell.id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
}



extension ProfileImageViewController {
    
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
    
    func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(collectionView)
    }
    
    func setUI() {
        imageView.image = UIImage(named: UserDefaultsManager.shared.image)
        DispatchQueue.main.async {//FIXME: customView에서 처리해줬는데 안되는 이유?
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
        navigationController?.setNavigationBar()
        
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        Constants.Mock.ProfileImages.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        let image = UIImage(named: Constants.Mock.ProfileImages.profileImageList[indexPath.item])?.withRenderingMode(.alwaysOriginal)
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
