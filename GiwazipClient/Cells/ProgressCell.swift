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
            silhouette.isHidden = isSelected
            view.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.black.cgColor
            view.layer.borderWidth = isSelected ? 3 : 0.5
        }
    }
    var progress: Double = 0 {
        didSet {
            progressChart.snp.makeConstraints {
                $0.height.equalTo(Double(frame.height) / 100 * progress)
            }
        }
    }

    // MARK: - View

    private let view: UIView = {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 0.5
        return $0
    }(UIView())

    private let progressChart: UIView = {
        $0.backgroundColor = .cyan
        return $0
    }(UIView())

    let categoryName: UILabel = {
        $0.text = "카테고리"
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let silhouette: UIView = {
        $0.backgroundColor = UIColor(white: 0, alpha: 0.05)
        return $0
    }(UIView())

    // MARK: - Life Cycle

    override private init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method

    private func setupCell() {
        addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(progressChart)
        progressChart.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
        }

        view.addSubview(categoryName)
        categoryName.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(silhouette)
        silhouette.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
