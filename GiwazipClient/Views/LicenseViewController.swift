//
//  LicenseViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

import UIKit

class LicenseViewController: BaseViewController {

    // MARK: - Property

    weak var delegate: SettingContentDelegate?
    
    // MARK: - Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = backBarButton(#selector(didTapBackButton))
    }
    
    @objc func didTapBackButton() {
        delegate?.popToSettingViewController()
    }
}
