//
//  UIViewController+Extension.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/23/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completionHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        alert.view.tintColor = .point
        
        present(alert, animated: true)
    }
}
