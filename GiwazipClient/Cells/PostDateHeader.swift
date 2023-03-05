//
//  PostDateHeader.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

import SnapKit

class PostDateHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "postDateHeader"
    
    // MARK: - View
    
    private let dateStack = UIView()
    
    private lazy var leftDashLine: UIView = {
        $0.layer.addSublayer(lineDashPattern(start: UIScreen.main.bounds.width / 3, end: 0))
        return $0
    }(UIView())
    
    private let postingDate: UILabel = {
        $0.text = "22.11.22"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return $0
    }(UILabel())
     
    private lazy var rightDashLine: UIView = {
        $0.layer.addSublayer(lineDashPattern(start: 0, end: UIScreen.main.bounds.width / 3))
        return $0
    }(UIView())
    
    // MARK: - LifeCycle
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupCell() {
        self.addSubview(dateStack)
        dateStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateStack.addSubview(leftDashLine)
        leftDashLine.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.height.equalTo(1)
        }
        
        dateStack.addSubview(postingDate)
        postingDate.snp.makeConstraints {
            $0.left.equalTo(leftDashLine.snp.right)
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.verticalEdges.equalToSuperview()
        }
        
        dateStack.addSubview(rightDashLine)
        rightDashLine.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.left.equalTo(postingDate.snp.right)
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.height.equalTo(1)
        }
    }
}
