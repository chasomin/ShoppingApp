//
//  NotificationTableViewCell.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/23/24.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var notificationSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    @IBAction func notificationSwitchTapped(_ sender: UISwitch) {
        
    }
    
}

extension NotificationTableViewCell {
    func setUI() {
        label.text = "푸시 알림"
        label.font = .regular
        label.textAlignment = .left
        
        notificationSwitch.tintColor = .point
         UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus {
                
            case .notDetermined: 
                print("한번만허용")
                
            case .denied:
//                self.notificationSwitch.isOn = false
                print("허용 안 함")

            case .authorized:
//                self.notificationSwitch.isOn = true
                print("허용")
            case .provisional:
                print("임시중단")

            case .ephemeral:
                print("푸시 설정이 App Clip에 대해서만 부분적으로 동의한 경우")
            @unknown default:
                print("Unknow Status")

            }
        })
    }
}
