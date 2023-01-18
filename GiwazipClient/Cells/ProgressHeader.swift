//
//  ProgressCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

class ProgressHeader: UICollectionReusableView {

    // MARK: - Property
    
    static let identifier = "progressHeader"
    
    // MARK: - View
    
    private let progressBlock: UIView = {
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
        addSubview(progressBlock)
        
        progressBlock.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.width.equalTo(snp.width)
            $0.height.equalTo(snp.height)
        }
    }
}
