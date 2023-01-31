//
//  BaseViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Life Cycle

    let screenWidth = UIScreen.main.bounds.width
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
