//
//  JoinViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/09.
//

import UIKit

class JoinViewController: UIViewController {

    // MARK: - View

    private let joinButton: UIButton = {
        $0.backgroundColor = .gray
        $0.setTitle("방 입장하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
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
    }

    private func layout() {
        view.addSubview(joinButton)

        joinButton.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 8,
            paddingRight: 16,
            height: 50
        )
    }
}
