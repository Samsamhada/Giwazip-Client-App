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
    
    private let controlBar: UIView = {
        $0.backgroundColor = .systemCyan
        return $0
    }(UIView())
    
    private let microCopy: UILabel = {
        $0.text = "아직 진행 중인 시공이 없습니다."
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        setupNavigationTitle()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
    private func setupNavigationTitle() {
        navigationLayout()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func navigationLayout() {
        navigationItem.titleView = titleView
        titleView.addSubview(titleName)
        titleView.addSubview(titleDate)

        titleView.snp.makeConstraints {
            $0.height.equalTo(self.navigationItem.titleView!.snp.height)
        }

        titleName.snp.makeConstraints {
            $0.top.left.right.equalTo(titleView)
            $0.bottom.equalTo(titleDate.snp.top)
        }

        titleDate.snp.makeConstraints {
            $0.bottom.left.right.equalTo(titleView)
        }
    }
    
    private func layout() {
        view.addSubview(controlBar)
//        view.addSubview(microCopy)
        view.addSubview(collectionView)

        controlBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.equalTo(20)
        }
        
//        microCopy.snp.makeConstraints {
//            $0.center.equalTo(view.snp.center)
//        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(controlBar.snp.bottom).offset(16)
            $0.width.equalTo(view.snp.width)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}
}
