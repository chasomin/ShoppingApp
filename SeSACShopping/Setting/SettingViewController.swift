//
//  SettingViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SettingViewController: UIViewController {
    let mainView = SettingView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        mainView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("here",UserDefaultsManager.shared.image)
        mainView.tableView.reloadData()
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
            
            cell.configureCell()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
            
            cell.textLabel?.text = Constants.Mock.Setting.title[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = ProfileViewController()
            
            vc.navigationItem.title = "프로필 수정"
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 4 {
            
            showAlert(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", buttonTitle: "확인") {
                UserDefaultsManager.shared.nickname = ""
                UserDefaultsManager.shared.image = ""
                UserDefaultsManager.shared.search = []
                UserDefaultsManager.shared.like = []
                UserDefaultsManager.shared.userState = false
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let vc = OnboardingViewController()
                
                let nav = UINavigationController(rootViewController: vc)
                
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
        }
        if indexPath.section == 1 && indexPath.row == 3 {
            
            let sb = UIStoryboard(name: "Notification", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: NotificationViewController.id) as! NotificationViewController
            
            vc.navigationItem.title = "알림 설정"
            
            navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
}
