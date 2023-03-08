//
//  PostingPhotoCell.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/21.
//

import UIKit

import SnapKit

class PostingPhotoCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "postingPhotoCell"

    // MARK: - View

    let postingImage: UIImageView = {
        $0.backgroundColor = .systemGray4
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        return $0
    }(UIImageView())
    
    let plusIcon: UIImageView = {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    let resolutionLabel: UILabel = {
        $0.text = TextLiteral.resolutionText
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
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
        self.addSubview(postingImage)
        postingImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        postingImage.addSubview(plusIcon)
        plusIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        postingImage.addSubview(resolutionLabel)
        resolutionLabel.snp.makeConstraints {
            $0.top.equalTo(plusIcon.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
