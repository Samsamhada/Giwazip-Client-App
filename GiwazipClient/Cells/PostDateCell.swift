//
//  PostDateCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

import SnapKit

class PostDateCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "postDateCell"
    
    // MARK: - View
    
    private let dateStack = UIView()
    
    private let leftDashLine: UIView = {
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    private let postingDate: UILabel = {
        $0.text = "22.11.22"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return $0
    }(UILabel())
     
    private let rightDashLine: UIView = {
        $0.backgroundColor = .gray
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
            $0.top.equalToSuperview().offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        
        dateStack.addSubview(leftDashLine)
        leftDashLine.snp.makeConstraints {
            $0.verticalEdges.left.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.height.equalTo(1)
        }
        
        dateStack.addSubview(postingDate)
        postingDate.snp.makeConstraints {
            $0.left.equalTo(leftDashLine.snp.right)
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.centerY.equalToSuperview()
        }
        
        dateStack.addSubview(rightDashLine)
        rightDashLine.snp.makeConstraints {
            $0.verticalEdges.right.centerY.equalToSuperview()
            $0.left.equalTo(postingDate.snp.right)
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.height.equalTo(1)
        }
    }
}
