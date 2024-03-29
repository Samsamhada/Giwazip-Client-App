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
    
    let contents = UIView()
    
    private let plusIcon: UIImageView = {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    private let minimumResolutionText: UILabel = {
        $0.text = TextLiteral.minimumResolutionText
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
        addSubview(postingImage)
        postingImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        postingImage.addSubview(contents)
        contents.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        contents.addSubview(plusIcon)
        plusIcon.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(super.frame.height/3)
        }
        
        contents.addSubview(minimumResolutionText)
        minimumResolutionText.snp.makeConstraints {
            $0.top.equalTo(plusIcon.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
