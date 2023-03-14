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

    func extractDate(_ originDate: String, _ asPeriod: Int = 0) -> String {
        let startIndex = originDate.index(originDate.startIndex, offsetBy: 2)
        let endIndex = originDate.index(originDate.startIndex, offsetBy: 10)

        var date = originDate[startIndex..<endIndex].split(separator: "-").map { String($0) }
        date[0] = String(format: "%02d", Int(date[0])! + asPeriod / 12 % 100)
        date[1] = String(format: "%02d", (Int(date[1])! - 1 + asPeriod) % 12 + 1)

        let newFormatDate = "\(date[0]).\(date[1]).\(date[2])"
        return newFormatDate
    }
}
