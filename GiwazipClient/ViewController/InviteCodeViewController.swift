//
//  InviteCodeViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import UIKit

class InviteCodeViewController: UIViewController {

    // MARK: - View

    private let inviteCodeView: UIView = {
        return $0
    }(UIView())

    private let phoneNumberField: UITextField = {
        $0.placeholder = "전화번호를 입력하세요."
        return $0
    }(UITextField())

    private let phoneNumberUnderLine: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())

    private let inviteCodeField: UITextField = {
        $0.placeholder = "초대코드를 입력하세요."
        return $0
    }(UITextField())

    private let inviteCodeUnderLine: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())

    private let submitButton: UIButton = {
        $0.backgroundColor = .gray
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }

    private func layout() {
        view.addSubview(inviteCodeView)
        inviteCodeView.addSubview(phoneNumberField)
        inviteCodeView.addSubview(phoneNumberUnderLine)
        inviteCodeView.addSubview(inviteCodeField)
        inviteCodeView.addSubview(inviteCodeUnderLine)
        inviteCodeView.addSubview(submitButton)

        inviteCodeView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 50,
            paddingLeft: 16,
            paddingBottom: 8,
            paddingRight: 16
        )

        phoneNumberField.anchor(
            top: inviteCodeView.topAnchor,
            left: inviteCodeView.leftAnchor,
            bottom: phoneNumberUnderLine.topAnchor,
            right: inviteCodeView.rightAnchor
        )

        phoneNumberUnderLine.anchor(
            left: inviteCodeView.leftAnchor,
            bottom: inviteCodeField.topAnchor,
            right: inviteCodeView.rightAnchor,
            paddingBottom: 50,
            height: 1
        )

        inviteCodeField.anchor(
            left: inviteCodeView.leftAnchor,
            bottom: inviteCodeUnderLine.topAnchor,
            right: inviteCodeView.rightAnchor
        )

        inviteCodeUnderLine.anchor(
            left: inviteCodeView.leftAnchor,
            right: inviteCodeView.rightAnchor,
            height: 1
        )

        submitButton.anchor(
            left: inviteCodeView.leftAnchor,
            bottom: inviteCodeView.bottomAnchor,
            right: inviteCodeView.rightAnchor,
            height: 50
        )
    }

    @objc func tapSubmitButton() {
        
    }
}
