//
//  ItemDetailViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit
import WebKit

class ItemDetailViewController: UIViewController {
    var urlString = "https://www.apple.com"

    @IBOutlet var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
        
    }
    



}
