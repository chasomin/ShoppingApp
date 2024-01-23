//
//  NotificationViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/23/24.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: NotificationTableViewCell.id, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: NotificationTableViewCell.id)
        
        tableView.rowHeight = UITableView.automaticDimension

    }
    

}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.id, for: indexPath) as! NotificationTableViewCell
        
        
        return cell
    }
    
    
}
