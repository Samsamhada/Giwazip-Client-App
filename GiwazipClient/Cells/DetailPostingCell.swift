//
//  DetailPostingCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/26.
//

import UIKit

import SnapKit

class DetailPostingCell: UICollectionViewCell {

    // MARK: - Property
    
    static let identifier = "detailPostingCell"
    
    // MARK: - View
    
    let postingImage: UIImageView = {
        $0.image = UIImage(named: "Test01")
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())

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
        self.addSubview(postingImage)
        postingImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
