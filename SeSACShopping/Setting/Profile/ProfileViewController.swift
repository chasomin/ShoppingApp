//
//  ProfileViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let userImageView = PointBorderUserImageView(frame: .zero)
    let editImageView = EditUserImageView(frame: .zero)
    let textfield = NicknameTextField()
    let stateLabel = UILabel()
    let doneButton = PointCornerRadiusButton()
    let lineView = UIView()
    let gesture = UITapGestureRecognizer()
    
    let num = Int.random(in: 1...14)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        setUI()
        setupConstraints()
        textfield.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
    }
    
    
    @objc func userImageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let vc = ProfileImageViewController()
        
        vc.navigationItem.title = self.navigationItem.title
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ProfileViewController {
    func configureHierarchy() {
        view.addSubview(userImageView)
        view.addSubview(editImageView)
        view.addSubview(textfield)
        view.addSubview(stateLabel)
        view.addSubview(doneButton)
        view.addSubview(lineView)
        view.addGestureRecognizer(gesture)
    }
    
    func setUI() {
        view.setBackgroundColor()
        
        navigationController?.setNavigationBar()
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]
        
        // FIXME: customview로 하니까 cornerradius 잘 안 됨
        DispatchQueue.main.async {
            self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
        }
        userImageView.isUserInteractionEnabled = true
        
        if UserDefaultsManager.shared.image == "" {
            userImageView.image = UIImage(named: "profile\(num)")
            UserDefaultsManager.shared.image = "profile\(num)"
        } else {
            userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
        }
        
        
        
        textfield.text = UserDefaultsManager.shared.nickname
        textfield.placeholder = "닉네임을 입력해주세요 :)"
        
        
        lineView.backgroundColor = .white
        
        stateLabel.font = .small
        stateLabel.text = ""
        
        doneButton.setTitle("완료", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.isEnabled = false
        
        gesture.addTarget(self, action: #selector(userImageViewTapped))
    }
    
    func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
        
        editImageView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(userImageView)
            make.height.width.equalTo(30)
        }
        
        textfield.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(textfield.snp.bottom).offset(7)
        }
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.horizontalEdges.equalTo(textfield.snp.horizontalEdges)
        }
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(lineView.snp.horizontalEdges)
            make.height.equalTo(40)
        }
    }
    
    @objc func doneButtonTapped() {
        if stateLabel.textColor == .point {
            
            UserDefaultsManager.shared.userState = true
            UserDefaultsManager.shared.nickname = textfield.text!
            
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
            stateLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요."
            stateLabel.textColor = .systemRed
            doneButton.isEnabled = false
        } else if isContainsNumber {
            stateLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            stateLabel.textColor = .systemRed
            doneButton.isEnabled = false
        } else if textfield.text!.count < 2 || textfield.text!.count > 9 {
            stateLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            stateLabel.textColor = .systemRed
            doneButton.isEnabled = false
        } else if textfield.text == UserDefaultsManager.shared.nickname{
            stateLabel.text = "현재 닉네임과 다른 닉네임으로 설정해주세요"
            stateLabel.textColor = .systemRed
            doneButton.isEnabled = false
        } else {
            stateLabel.text = "사용할 수 있는 닉네임이에요."
            stateLabel.textColor = .point
            doneButton.isEnabled = true
        }
    }
}
