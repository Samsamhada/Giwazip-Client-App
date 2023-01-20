//
//  EnterViewController.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/17.
//

import UIKit

import SnapKit

class EnterViewController: BaseViewController {
    
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
    
    private let phoneNumberInput: CustomUITextField = {
        $0.placeholder = "1234 - 5678"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.keyboardType = .numberPad
        $0.addTarget(self, action: #selector(checkPhoneNumberLength), for: .editingChanged)
        $0.addTarget(self, action: #selector(checkButtonCondition), for: .editingChanged)
        return $0
    }(CustomUITextField())
    
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
        $0.placeholder = "AB12D9"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.keyboardType = .asciiCapable
        $0.addTarget(self, action: #selector(checkButtonCondition), for: .editingChanged)
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
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapEnterButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - Method
    
    override func attribute() {
        super.attribute()
        setupNotificationCenter()
    }
    
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
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(16)
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
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        inviteCodeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        inviteCodeInput.snp.makeConstraints {
            $0.top.equalTo(inviteCodeLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        inviteCodeUnderLine.snp.makeConstraints {
            $0.top.equalTo(inviteCodeInput.snp.bottom).offset(3)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        enterButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
    }
    
    @objc func checkPhoneNumberLength() {
        guard let phoneNumber = phoneNumberInput.text?.replacingOccurrences(of: " - ", with: "")
        else { return }
        if phoneNumber.count >= 8 {
            let endIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 8)
            let fixedText = phoneNumber[phoneNumber.startIndex..<endIndex]
            phoneNumberInput.text = String(fixedText).changePhoneNumberStyle()
        }
    }
    
    @objc func checkButtonCondition() {
        guard let phoneNumber = phoneNumberInput.text?.replacingOccurrences(of: " - ", with: ""),
              let inviteCode = inviteCodeInput.text
        else { return }
        
        if (phoneNumber.count == 8) && (inviteCode.count > 0) {
            enterButton.isEnabled = true
            enterButton.backgroundColor = .blue
        } else {
            enterButton.isEnabled = false
            enterButton.backgroundColor = .gray
        }
    }
    
    private func makeAlert(title: String? = nil, message: String? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true)
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.enterButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.enterButton.transform = .identity
        })
    }
    
    @objc func tapEnterButton() {
        guard let inviteCode = inviteCodeInput.text else { return }
        // TODO: - 추후 API 통신이 되면 if문 로직 고칠 예정
        if inviteCode == "aaabbb" {
            print("다음 뷰로 이동")
        } else {
            makeAlert(title: "오류", message: "초대코드가 일치하지 않습니다")
        }
    }
}

extension String {
    func changePhoneNumberStyle() -> String {
        if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})",
                                                options: .caseInsensitive) {
            let modString = regex.stringByReplacingMatches(in: self,
                                                           range: NSRange(self.startIndex..., in: self),
                                                           withTemplate: "$1 - $2")
            return modString
        }
        return self
    }
}

class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
