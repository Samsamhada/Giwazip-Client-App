//
//  SubViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

protocol SubViewControllerDelegate {
    func logout()
}

class SubViewController: BaseViewController {

    // MARK: - Property

    var delegate: SubViewControllerDelegate?

    // MARK: - Method

    override func attribute() {
        super.attribute()

        view.backgroundColor = .red

        let item = UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(logoutButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
    }

    @objc func logoutButtonDidTap() {
        self.delegate?.logout()
    }
}
