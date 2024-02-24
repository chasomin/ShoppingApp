//
//  ProfileViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileViewController: UIViewController {
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    
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
        
        viewModel.outputNickName.bind { value in
            self.mainView.stateLabel.text = value
        }
        viewModel.outputVaildState.bind { value in
            self.mainView.stateLabel.textColor = self.setTextColor(value)
            self.mainView.doneButton.isEnabled = value
        }

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
        guard let text = mainView.textfield.text else { return }
        viewModel.inputDoneButton.value = text
        setViewController()
    }
    
    func setViewController() {
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

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.inputNickName.value = text
    }
    
    func setTextColor(_ value: Bool) -> UIColor {
        return value ? .point : .systemRed
    }

}
