//
//  HistoryCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/17.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "historyCell"
    
    // MARK: - View
    
    private let chipFrame: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2
        $0.layer.opacity = 0.8
        return $0
    }(UIView())
    
    private let chipLabel: UILabel = {
        $0.text = "카테고리"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let postImage: UIImageView = {
        $0.image = UIImage(systemName: "gearshape")
        $0.backgroundColor = .green
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        return $0
    }(UIImageView())
    
    private let descriptionBackground: UIView = {
        $0.backgroundColor = .black
        $0.layer.opacity = 0.7
        return $0
    }(UIView())
    
    private let postDescription: UILabel = {
        $0.text = "TEST용TEXT TEST용TEXT TEST용TEXT TEST용TEXT TEST용TEXT TEST용TEXT TEST용TEXT TEST용TEXT"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
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
        self.addSubview(postImage)
        postImage.addSubview(chipFrame)
        postImage.addSubview(chipLabel)
        postImage.addSubview(descriptionBackground)
        postImage.addSubview(postDescription)
        
        postImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(UIScreen.main.bounds.width / 4 * 3)
        }
        
        chipFrame.snp.makeConstraints {
            $0.top.left.equalTo(8)
        }
        
        chipLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(chipFrame).inset(8)
            $0.left.right.equalTo(chipFrame).inset(12)
        }
        
        descriptionBackground.snp.makeConstraints {
            $0.bottom.width.equalToSuperview()
        }
        
        postDescription.snp.makeConstraints {
            $0.top.bottom.equalTo(descriptionBackground).inset(12)
            $0.left.right.equalTo(descriptionBackground).inset(16)
        }
    }
}
