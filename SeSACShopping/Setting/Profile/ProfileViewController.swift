//
//  ProfileViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileViewController: UIViewController {
    let mainView = ProfileView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.textfield.delegate = self
        navigationController?.setNavigationBar()
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]
        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        mainView.gesture.addTarget(self, action: #selector(userImageViewTapped))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }
    
    
    @objc func userImageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let vc = ProfileImageViewController()
        
        vc.navigationItem.title = self.navigationItem.title
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ProfileViewController {
    @objc func doneButtonTapped() {
        if mainView.stateLabel.textColor == .point {
            
            UserDefaultsManager.shared.userState = true
            UserDefaultsManager.shared.nickname = mainView.textfield.text!
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let tabbar = UITabBarController()
            
            let searchViewController = UINavigationController(rootViewController: SearchViewController())
            let settingViewController = UINavigationController(rootViewController: SettingViewController())

            searchViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"),selectedImage: UIImage(systemName: "magnifyingglass"))
            settingViewController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"),selectedImage: UIImage(systemName: "person"))
            
            tabbar.viewControllers = [searchViewController, settingViewController]

            sceneDelegate?.window?.rootViewController = tabbar
            sceneDelegate?.window?.makeKeyAndVisible()
        }
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var isContainsNumber = false
        var isContainsSymbol = false
        
        textField.text!.forEach {
            if "0123456789".contains($0) {
                isContainsNumber = true
            }
            if "@#$%".contains($0) {
                isContainsSymbol = true
            }
        }
        
        if isContainsSymbol {
            mainView.stateLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요."
            mainView.stateLabel.textColor = .systemRed
            mainView.doneButton.isEnabled = false
        } else if isContainsNumber {
            mainView.stateLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            mainView.stateLabel.textColor = .systemRed
            mainView.doneButton.isEnabled = false
        } else if mainView.textfield.text!.count < 2 || mainView.textfield.text!.count > 9 {
            mainView.stateLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            mainView.stateLabel.textColor = .systemRed
            mainView.doneButton.isEnabled = false
        } else if mainView.textfield.text == UserDefaultsManager.shared.nickname{
            mainView.stateLabel.text = "현재 닉네임과 다른 닉네임으로 설정해주세요"
            mainView.stateLabel.textColor = .systemRed
            mainView.doneButton.isEnabled = false
        } else {
            mainView.stateLabel.text = "사용할 수 있는 닉네임이에요."
            mainView.stateLabel.textColor = .point
            mainView.doneButton.isEnabled = true
        }
    }
}
