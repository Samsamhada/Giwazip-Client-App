//
//  ASCell.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/31.
//

import UIKit

import SnapKit

class ASCell: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "ASCell"
    
    private let remainedDuration: UILabel = {
        $0.text = "AS 기간(~23.11.12)"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    private let zStack: UIView = UIView()
    
    let remainedDay: UILabel = {
        $0.text = "102일"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = .blue
        return $0
    }(UILabel())
    
    private let remainedText: UILabel = {
        $0.text = "남았어요"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }
    
    private func layout() {
        addSubview(remainedDuration)
        remainedDuration.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(15)
        }
        
        addSubview(zStack)
        zStack.snp.makeConstraints {
            $0.top.equalTo(remainedDuration.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        zStack.addSubview(remainedDay)
        remainedDay.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        zStack.addSubview(remainedText)
        remainedText.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(remainedDay.snp.right).offset(4)
            $0.right.equalToSuperview()
        }
    }
}
