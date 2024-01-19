//
//  OnboardingViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor()
        
        titleImageView.image = UIImage(named: "sesacShopping")
        titleImageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFit
        
        startButton.setPointButton()
        startButton.setTitle("시작하기", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDefaultsManager.shared.image = ""
    }

    @objc func startButtonTapped() {
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.id) as! ProfileViewController
//        let nav = UINavigationController(rootViewController: vc)

        vc.navigationItem.title = "프로필 설정"
        
//        nav.pushViewController(nav, animated: true)
        navigationController?.pushViewController(vc, animated: true)


    }


}
