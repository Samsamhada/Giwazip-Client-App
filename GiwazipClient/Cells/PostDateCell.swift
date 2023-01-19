//
//  PostDateCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

class PostDateCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "postDateCell"
    
    // MARK: - View
    
    private let dateStack = UIView()
    
    private let leftLineDot: UIView = {
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
    
    private let rightLineDot: UIView = {
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
        dateStack.addSubview(leftLineDot)
        dateStack.addSubview(postingDate)
        dateStack.addSubview(rightLineDot)
        
        dateStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
        }
        
        leftLineDot.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.right.equalTo(postingDate.snp.left)
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.height.equalTo(1)
        }
        
        postingDate.snp.makeConstraints {
            $0.right.equalTo(rightLineDot.snp.left)
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.centerY.equalToSuperview()
        }
        
        rightLineDot.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.height.equalTo(1)
        }
    }
}
