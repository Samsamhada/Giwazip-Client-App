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
        $0.layer.borderColor = CGColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
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
            $0.top.equalTo(snp.top)
            $0.left.equalTo(snp.left).offset(16)
            $0.right.equalTo(snp.right).offset(-16)
            $0.height.equalTo(UIScreen.main.bounds.width / 4 * 3)
        }
        
        chipFrame.snp.makeConstraints {
            $0.topMargin.equalTo(8)
            $0.leftMargin.equalTo(8)
        }
        
        chipLabel.snp.makeConstraints {
            $0.top.equalTo(chipFrame.snp.top).offset(8)
            $0.left.equalTo(chipFrame.snp.left).offset(12)
            $0.bottom.equalTo(chipFrame.snp.bottom).offset(-8)
            $0.right.equalTo(chipFrame.snp.right).offset(-12)
        }
        
        descriptionBackground.snp.makeConstraints {
            $0.width.equalTo(postImage.snp.width)
            $0.bottom.equalTo(postImage.snp.bottom)
        }
        
        postDescription.snp.makeConstraints {
            $0.left.equalTo(descriptionBackground.snp.left).offset(16)
            $0.right.equalTo(descriptionBackground.snp.right).offset(-16)
            $0.bottom.equalTo(descriptionBackground.snp.bottom).offset(-12)
            $0.top.equalTo(descriptionBackground.snp.top).offset(12)
        }
    }
}
