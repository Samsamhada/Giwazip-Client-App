//
//  ProgressCell.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/11.
//

import UIKit

import SnapKit

class ProgressCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "progressCell"
    override var isSelected: Bool {
        didSet {
            unselectOpacity.isHidden = isSelected
            categoryFrame.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.black.cgColor
            categoryFrame.layer.borderWidth = isSelected ? 3 : 0.5
            categoryName.textColor = isSelected ? .black : .gray
        }
    }
    var progress: CGFloat = 0 {
        didSet {
            progressChart.progress = progress
        }
    }

    // MARK: - View

    private let categoryFrame: UIView = {
        $0.layer.borderWidth = 0.5
        return $0
    }(UIView())

    private let progressChart: WaveView = {
        $0.backgroundColor = .clear
        return $0
    }(WaveView())

    let categoryName: UILabel = {
        $0.text = "카테고리"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    private let unselectOpacity: UIView = {
        $0.backgroundColor = UIColor(white: 0, alpha: 0.05)
        return $0
    }(UIView())

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method

    private func setupCell() {
        addSubview(categoryFrame)
        categoryFrame.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        categoryFrame.addSubview(progressChart)
        progressChart.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        categoryFrame.addSubview(categoryName)
        categoryName.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        categoryFrame.addSubview(unselectOpacity)
        unselectOpacity.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
