//
//  OnboardingViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    let mainView = OnboardingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDefaultsManager.shared.image = ""
    }
    

    @objc func startButtonTapped() {
        
        let vc = ProfileViewController()

        vc.navigationItem.title = "프로필 설정"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
