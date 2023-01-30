//
//  PostCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/26.
//

import UIKit

import SnapKit

class PostCell: UICollectionViewCell {

    // MARK: - Property
    
    static let identifier = "PostCell"
    
    // MARK: - View
    
    let postingImage: UIImageView = {
        $0.image = UIImage(named: "Test01")
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    
    let whiteBlock: UIView = {
        $0.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.5)
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
        addSubview(postingImage)
        postingImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(whiteBlock)
        whiteBlock.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
