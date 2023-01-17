//
//  HistoryViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/17.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController {
    
    private let titleView: UIView = {
        return $0
    }(UIView())
    
    private let titleName: UILabel = {
        $0.text = "디너집"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let titleDate: UILabel = {
        $0.text = "22.11.11~23.01.13"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func layout() {
        titleView.addSubview(titleName)
        titleView.addSubview(titleDate)
        
        titleView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.navigationItem.titleView!)
        }
        titleName.snp.makeConstraints {
            $0.top.left.right.equalTo(titleView)
            $0.bottom.equalTo(titleDate.snp.top)
        }
        titleDate.snp.makeConstraints {
            $0.bottom.left.right.equalTo(titleView)
        }
    }
}
