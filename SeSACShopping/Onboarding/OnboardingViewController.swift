//
//  OnboardingViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    let titleImageView = UIImageView()
    let imageView = UIImageView()
    let startButton = PointCornerRadiusButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor()
        
        configureHierarchy()
        setUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDefaultsManager.shared.image = ""
    }
    
    
    func configureHierarchy() {
        view.addSubview(titleImageView)
        view.addSubview(imageView)
        view.addSubview(startButton)
    }
    
    func setUI() {
        titleImageView.image = UIImage(named: "sesacShopping")
        titleImageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFit
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(titleImageView.snp.width).multipliedBy(1.3/2)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(imageView.snp.width)

        }
        startButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview().inset(15)
            
        }
    }

    @objc func startButtonTapped() {
        
        let vc = ProfileViewController()

        vc.navigationItem.title = "프로필 설정"
        
        navigationController?.pushViewController(vc, animated: true)


    }


}
