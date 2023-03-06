//
//  NoticeContentCell.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/03/06.
//

import UIKit

import SnapKit

class NoticeContentCell: UICollectionViewCell {

    let writer: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.textAlignment = .right
        return $0
    }(UILabel())

    let content: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        addSubview(writer)
        writer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(32)
        }

        addSubview(content)
        content.snp.makeConstraints {
            $0.top.equalTo(writer.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
