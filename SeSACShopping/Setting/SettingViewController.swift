//
//  SettingViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    let setting: [String] = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"]
    let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", preferredStyle: .alert)
    

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]

        view.setBackgroundColor()
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionFooterHeight = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let xibProfile = UINib(nibName: ProfileTableViewCell.id, bundle: nil)
        tableView.register(xibProfile, forCellReuseIdentifier: ProfileTableViewCell.id)
        
        let xibSetting = UINib(nibName: SettingTableViewCell.id, bundle: nil)
        tableView.register(xibSetting, forCellReuseIdentifier: SettingTableViewCell.id)
        setAlert()
    }
    


}

extension SettingViewController {
    func setAlert() {
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        let okButton = UIAlertAction(title: "확인", style: .default) {_ in
            UserDefaultsManager.shared.nickname = ""
            UserDefaultsManager.shared.image = ""
            UserDefaultsManager.shared.search = []
            UserDefaultsManager.shared.like = []
            UserDefaultsManager.shared.userState = false
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: OnboardingViewController.id) as! OnboardingViewController
            let nav = UINavigationController(rootViewController: vc)

            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)

    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as! ProfileTableViewCell
            
//            cell.configureCell()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
            
            cell.textLabel?.text = setting[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.id) as! ProfileViewController
            
            vc.navigationItem.title = "프로필 수정"
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 4 {
            
            
            present(alert, animated: true)
        }
    }
    
}
