//
//  OnboardingView.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/1/24.
//

import UIKit

class OnboardingView: BaseView {
    let titleImageView = UIImageView()
    let imageView = UIImageView()
    let startButton = PointCornerRadiusButton()

    override func configureHierarchy() {
        addSubview(titleImageView)
        addSubview(imageView)
        addSubview(startButton)

    }
    
    override func configureLayout() {
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(titleImageView.snp.width).multipliedBy(1.3/2)
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(imageView.snp.width)

        }
        startButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview().inset(15)
            
        }
    }
    
    override func configureView() {
        titleImageView.image = Constants.Image.onboardingLogoImage
        titleImageView.contentMode = .scaleAspectFit
        
        imageView.image = Constants.Image.onboardingImage
        imageView.contentMode = .scaleAspectFit
        
        startButton.setTitle("시작하기", for: .normal)

    }
}

