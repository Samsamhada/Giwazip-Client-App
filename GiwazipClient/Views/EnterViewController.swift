//
//  EnterViewController.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/17.
//

import UIKit

import SnapKit

protocol EnterViewControllerDelegate {
    func pushToSegmentViewController()
    func popToSettingViewController()
}

class EnterViewController: BaseViewController {
    
    // MARK: - Property
    
    var delegate: EnterViewControllerDelegate?
    var isEnterView = true
    
    // MARK: - View
    
    private let phoneNumberGuideLabel: UILabel = {
        $0.text = TextLiteral.phoneNumberGuideText
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let hStackView = UIView()
    
    private let startPhoneNumber: UILabel = {
        $0.text = TextLiteral.phoneNumberPrefix
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let phoneNumberInput: CustomUITextField = {
        $0.placeholder = TextLiteral.phoneNumberPlaceHolder
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

    private let inviteCodeGuideLabel: UILabel = {
        $0.text = TextLiteral.inviteCodeGuideText
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let inviteCodeInput: UITextField = {
        $0.placeholder = TextLiteral.inviteCodePlaceHolder
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.keyboardType = .asciiCapable
        $0.addTarget(self, action: #selector(checkInviteCodeLength), for: .editingChanged)
        $0.addTarget(self, action: #selector(checkButtonCondition), for: .editingChanged)
        return $0
    }(UITextField())
    
    private let inviteCodeUnderLine: UIView = {
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    private let enterButton: UIButton = {
        $0.configuration?.title = TextLiteral.enterButtonText
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .blue
        $0.configuration?.background.cornerRadius = 0
        $0.configuration?.contentInsets.bottom = 20
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapEnterButton), for: .touchUpInside)
        return $0
    }(UIButton(configuration: .filled()))
    
    // MARK: - Method
    
    override func attribute() {
        super.attribute()
        setupNotificationCenter()
        
        navigationItem.hidesBackButton = true

        if isEnterView {
            enterButton.configuration?.title = TextLiteral.enterButtonText
            inviteCodeInput.isHidden = false
            inviteCodeUnderLine.isHidden = false
            inviteCodeGuideLabel.isHidden = false
        } else {
            enterButton.configuration?.title = "수정 완료"
            inviteCodeInput.isHidden = true
            inviteCodeUnderLine.isHidden = true
            inviteCodeGuideLabel.isHidden = true

            navigationItem.leftBarButtonItem = backBarButton(#selector(didTapBackButton))
        }
    }
    
    @objc func didTapBackButton() {
        delegate?.popToSettingViewController()
    }
    
    override func layout() {
        
        view.addSubview(phoneNumberGuideLabel)
        phoneNumberGuideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(hStackView)
        hStackView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberGuideLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        hStackView.addSubview(startPhoneNumber)
        startPhoneNumber.snp.makeConstraints {
            $0.verticalEdges.left.equalToSuperview()
        }
        
        hStackView.addSubview(phoneNumberInput)
        phoneNumberInput.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.left.equalTo(startPhoneNumber.snp.right)
        }
        
        view.addSubview(phoneNumberUnderLine)
        phoneNumberUnderLine.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        view.addSubview(inviteCodeGuideLabel)
        inviteCodeGuideLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberInput.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(inviteCodeInput)
        inviteCodeInput.snp.makeConstraints {
            $0.top.equalTo(inviteCodeGuideLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        view.addSubview(inviteCodeUnderLine)
        inviteCodeUnderLine.snp.makeConstraints {
            $0.top.equalTo(inviteCodeInput.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
    
    private func checkStringLength(text: String, count: Int) -> String {
        if text.count > count {
            let endIndex = text.index(text.startIndex, offsetBy: count)
            let fixedText = text[text.startIndex..<endIndex]
            return String(fixedText)
        }
        return text
    }
    
    @objc func checkPhoneNumberLength() {
        guard let phoneNumber = phoneNumberInput.text?.replacingOccurrences(of: " - ", with: "") else { return }

        phoneNumberInput.text = checkStringLength(text: phoneNumber, count: 8).changePhoneNumberStyle()
    }
    
    @objc func checkInviteCodeLength() {
        guard let inviteCode = inviteCodeInput.text else { return }

        inviteCodeInput.text = checkStringLength(text: inviteCode, count: 6)
    }
    
    @objc func checkButtonCondition() {
        guard let phoneNumber = phoneNumberInput.text?.replacingOccurrences(of: " - ", with: ""),
              let inviteCode = inviteCodeInput.text
        else { return }
        
        if isEnterView {
            enterButton.isEnabled = (phoneNumber.count == 8) && (inviteCode.count == 6) ? true: false
        } else {
            enterButton.isEnabled = (phoneNumber.count == 8) ? true: false
        }
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
        
        switch isEnterView {
        case true:
//            if inviteCode == "aaabbb" {
                delegate?.pushToSegmentViewController()
//            } else {
//                makeAlert(title: TextLiteral.errorAlertTitle,
//                          message: TextLiteral.inviteCodeErrorAlertMessage)
//            }
        case false:
            delegate?.popToSettingViewController()
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
