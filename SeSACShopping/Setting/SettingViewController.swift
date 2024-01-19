//
//  SettingViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SettingViewController: UIViewController {
    
    let setting: [String] = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"]

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.text]

        view.setBackgroundColor()
        tableView.setBackgroundColor()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let xibProfile = UINib(nibName: ProfileTableViewCell.id, bundle: nil)
        tableView.register(xibProfile, forCellReuseIdentifier: ProfileTableViewCell.id)
        
        let xibSetting = UINib(nibName: SettingTableViewCell.id, bundle: nil)
        tableView.register(xibSetting, forCellReuseIdentifier: SettingTableViewCell.id)
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
            
            cell.textLabel?.text = setting[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let sb = UIStoryboard(name: "Profile", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.id) as! ProfileViewController
            
            vc.userImageView.image = UIImage(named: UserDefaultsManager.shared.image)
            vc.textfield.text = UserDefaultsManager.shared.nickname
            
            vc.navigationItem.title = "프로필 수정"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
