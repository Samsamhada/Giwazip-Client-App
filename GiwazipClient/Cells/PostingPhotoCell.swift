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
        $0.backgroundColor = .gray
        $0.image = UIImage(systemName: "gearshape")
        $0.layer.cornerRadius = 16
        return $0
    }(UIImageView())
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func layout() {
        self.addSubview(postingImage)
        postingImage.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
