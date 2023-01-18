//
//  EnterViewController.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/17.
//

import UIKit

import SnapKit

class EnterViewController: BaseViewController {
    
    // MARK: - Property
    
    private var phoneNumber = ""
    
    // MARK: - View
    
    private let phoneNumberLabel: UILabel = {
        $0.text = "전화번호를 입력해주세요"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let hStackView = UIView()
    
    private let startPhoneNumber: UILabel = {
        $0.text = "010 - "
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let phoneNumberInput: UITextField = {
        $0.placeholder = "1234 - 5678"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.keyboardType = .numberPad
        return $0
    }(UITextField())
    
    private let phoneNumberUnderLine: UIView = {
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    private let inviteCodeLabel: UILabel = {
        $0.text = "초대코드를 입력해주세요"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let inviteCodeInput: UITextField = {
        $0.placeholder = "AB12D"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UITextField())
    
    private let inviteCodeUnderLine: UIView = {
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    private let enterButton: UIButton = {
        $0.setTitle("입장하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton())
    
    // MARK: - Method
    
    override func layout() {
        view.addSubview(phoneNumberLabel)
        view.addSubview(hStackView)
        hStackView.addSubview(startPhoneNumber)
        hStackView.addSubview(phoneNumberInput)
        view.addSubview(phoneNumberUnderLine)
        
        view.addSubview(inviteCodeLabel)
        view.addSubview(inviteCodeInput)
        view.addSubview(inviteCodeUnderLine)
        
        view.addSubview(enterButton)
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        startPhoneNumber.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
        }
        
        phoneNumberInput.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(startPhoneNumber.snp.right)
        }
        
        phoneNumberUnderLine.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(3)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
        }
        
        inviteCodeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        inviteCodeInput.snp.makeConstraints {
            $0.top.equalTo(inviteCodeLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        inviteCodeUnderLine.snp.makeConstraints {
            $0.top.equalTo(inviteCodeInput.snp.bottom).offset(3)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(1)
        }
        
        enterButton.snp.makeConstraints {
            $0.left.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
    }
}
