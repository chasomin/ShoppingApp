//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    var total = 0

    @IBOutlet var totalLabel: UILabel!
    
    @IBOutlet var accuracyButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPriceButton: UIButton!
    @IBOutlet var lowPriceButton: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    



}


extension SearchResultViewController {
    func setUI() {
        totalLabel.font = .regularBold
        totalLabel.textColor = .point
        totalLabel.text = "\(total) 개의 검색 결과"
        
        
        designButton(accuracyButton, active: true)
        designButton(dateButton, active: false)
        designButton(highPriceButton, active: false)
        designButton(lowPriceButton, active: false)

    }
    
    func designButton(_ button: UIButton, active: Bool) {
        if active {
            button.backgroundColor = .white
            button.tintColor = .black
        } else {
            button.tintColor = .white
        }
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
}
