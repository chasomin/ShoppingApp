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
        
        titleImageView.image = UIImage(named: "sesacShopping")
        titleImageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFit
        
        startButton.setPointButton()
        startButton.setTitle("시작하기", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

    }

    @objc func startButtonTapped() {
        UserDefaultsManager.shared.userState = true
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.id) as! ProfileViewController
        let nav = UINavigationController(rootViewController: vc)

        vc.navigationItem.title = "프로필 설정"
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }


}
