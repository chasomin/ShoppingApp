//
//  NotificationViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/23/24.
//

extension NotificationViewController: SominDelegate {
    func didBecomeActive() {
        DispatchQueue.main.async {
            print("델리게이트 함수")
            
            self.tableView.reloadData()
        }
    }
}

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Somin.shared.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: NotificationTableViewCell.id, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: NotificationTableViewCell.id)
        
        tableView.rowHeight = UITableView.automaticDimension

    }
    

    
    @objc func showLocationSettingAlert() {
        
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            // 아이폰 설정으로 이동
            // 설정 화면에 갈지, 앱 상세 페이지까지 유도해줄지는 모른다
            // 한 번도 직접 설정에서 사용자가 앱 설정 상세 페이지까지 들어간 적이 없다면
            // 막 다운 받은 앱이라서 설정 상세 페이지까지 갈 준비가 시스템적으로 안되어있거나
            
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 가주세요")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
        self.tableView.reloadData()
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.id, for: indexPath) as! NotificationTableViewCell
        
        cell.notificationSwitch.addTarget(self, action: #selector(showLocationSettingAlert), for: .touchUpInside)
        
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus {
                
            case .notDetermined:
                print("한번만허용")
                
            case .denied:
                DispatchQueue.main.async {
                    cell.notificationSwitch.isOn = false
                }
                print("허용 안 함")
                
            case .authorized:
                DispatchQueue.main.async {
                    cell.notificationSwitch.isOn = true
                }
                print("허용")
            
            default:
                print("ERROR")
            }
        })

        
        return cell
    }
    
    
}
