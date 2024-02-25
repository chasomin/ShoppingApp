//
//  ProfileView.swift
//  SeSACShopping
//
//  Created by 차소민 on 2/1/24.
//

import UIKit

class ProfileView: BaseView {
    let userImageView = PointBorderUserImageView(frame: .zero)
    let editImageView = EditUserImageView(frame: .zero)
    let textfield = NicknameTextField()
    let stateLabel = UILabel()
    let doneButton = PointCornerRadiusButton()
    let lineView = UIView()
    let gesture = UITapGestureRecognizer()
    
    let num = Int.random(in: 1...14)
    
    override func configureHierarchy() {
        addSubview(userImageView)
        addSubview(editImageView)
        addSubview(textfield)
        addSubview(stateLabel)
        addSubview(doneButton)
        addSubview(lineView)
        userImageView.addGestureRecognizer(gesture)
    }
    
    override func configureLayout() {
        userImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
        
        editImageView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(userImageView)
            make.height.width.equalTo(30)
        }
        
        textfield.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(textfield.snp.bottom).offset(7)
        }
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.horizontalEdges.equalTo(textfield.snp.horizontalEdges)
        }
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(stateLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(lineView.snp.horizontalEdges)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        setBackgroundColor()
        
        userImageView.isUserInteractionEnabled = true

        textfield.text = UserDefaultsManager.shared.nickname
        textfield.placeholder = "닉네임을 입력해주세요 :)"
        
        
        lineView.backgroundColor = .white
        
        stateLabel.font = .small
        stateLabel.text = ""
        
        doneButton.setTitle("완료", for: .normal)
        doneButton.isEnabled = false
        
    }
}
