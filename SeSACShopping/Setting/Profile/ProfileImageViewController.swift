//
//  ProfileImageViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
    let mainView = ProfileImageView()
    var viewModel = ProfileImageViewModel()
    let profileImageList = Constants.Mock.ProfileImages.profileImageList
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        
        navigationController?.setNavigationBar()
        
        viewModel.output.bind { value in
            self.mainView.collectionView.reloadData()
            self.mainView.imageView.image = UIImage(named: UserDefaultsManager.shared.image)
        }

    }
}


extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        
        let image = UIImage(named: profileImageList[indexPath.item])?.withRenderingMode(.alwaysOriginal)
        cell.imageButton.setImage(image, for: .normal)
        
        cell.imageButton.tag = indexPath.item + 1
        
        if UserDefaultsManager.shared.image == "profile\(cell.imageButton.tag)" {
            cell.imageButton.layer.borderWidth = 5
        } else {
            cell.imageButton.layer.borderWidth = 0
        }
            
        cell.imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func imageButtonTapped(sender: UIButton) {
        viewModel.input.value = sender.tag
    }
    

}
