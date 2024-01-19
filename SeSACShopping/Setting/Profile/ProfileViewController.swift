//
//  ProfileViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/19/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var editImageView: UIImageView!
    @IBOutlet var textfield: UITextField!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var lineView: UIView!
    
    
    let num = Int.random(in: 1...14)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        textfield.delegate = self

    }
    
    @IBAction func userImageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ProfileImageViewController.id) as! ProfileImageViewController
        vc.navigationItem.title = self.navigationItem.title
        vc.image = "profile\(num)"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension ProfileViewController {
    func setUI() {
        view.setBackgroundColor()
        
        userImageView.circleBorder()
        userImageView.isUserInteractionEnabled = true
        
        userImageView.image = UIImage(named: "profile\(num)")
        
        //FIXME: asset 이미지로 변경하기
        editImageView.image = UIImage(named: "camera.fill")
        editImageView.tintColor = .white
        editImageView.backgroundColor = .point
        DispatchQueue.main.async {
            self.editImageView.layer.cornerRadius = self.editImageView.frame.width / 2
        }
        editImageView.layer.borderColor = UIColor.white.cgColor
        editImageView.layer.borderWidth = 3
        
        
        
        textfield.borderStyle = .none
        textfield.clipsToBounds = true
        textfield.placeholder = "닉네임을 입력해주세요 :)"
        
        lineView.backgroundColor = .white
        
        stateLabel.font = .small
        stateLabel.text = ""
        
        doneButton.setPointButton()
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
//        if textfield.text == "" || textfield.text == UserDefaultsManager.shared.nickname {
        doneButton.isEnabled = false
//        } else {
//            doneButton.isEnabled = true
//        }
//        
        
    }
    
    @objc func doneButtonTapped() {
        if stateLabel.textColor == .point {

            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
            
            sceneDelegate?.window?.rootViewController = vc
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
            stateLabel.text = "닉네임에 \(textfield.text!.last!) 는 포함할 수 없어요."
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
        } else if textfield.text != UserDefaultsManager.shared.nickname {
            stateLabel.text = "사용할 수 있는 닉네임이에요."
            stateLabel.textColor = .point
            doneButton.isEnabled = true
        }
    }
}