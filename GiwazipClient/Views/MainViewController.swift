//
//  MainViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

protocol MainViewControllerDelegate {
    func login()
}

class MainViewController: BaseViewController {

    // MARK: - Property

    var delegate: MainViewControllerDelegate?

    // MARK: - Method

    override func attribute() {
        super.attribute()

        let item = UIBarButtonItem(title: "로그인", style: .plain, target: self, action: #selector(loginButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
    }

    @objc func loginButtonDidTap() {
        self.delegate?.login()
    }
}
