//
//  SplashViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/17.
//

import UIKit

import SnapKit

protocol SplashViewControllerDelegate {
    func pushToEnterViewController()
}

class SplashViewController: BaseViewController {

    // MARK: - Property

    var delegate: SplashViewControllerDelegate?
    
    private let enterButton: UIButton = {
        $0.setTitle(TextLiteral.enterButtonText, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - Method

    override func layout() {
        super.layout()

        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
    }
    
    @objc func didTapEnterButton() {
        delegate?.pushToEnterViewController()
    }
}
