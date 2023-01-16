//
//  SplashViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/17.
//

import UIKit
import SnapKit

class SplashViewController: BaseViewController {

    // MARK: - Property

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
        super.layout()

        view.addSubview(enterButton)
        enterButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
    }
}
