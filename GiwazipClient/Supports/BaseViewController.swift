//
//  BaseViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
        hidekeyboardWhenTappedAround()
    }

    // MARK: - Method

    func attribute() {
        view.backgroundColor = .white
    }

    func layout() {}
}
