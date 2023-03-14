//
//  ASView.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/03/14.
//

import UIKit

import SnapKit

final class ASView: UIView {

    // MARK: - View

    private let asTitleLabel: UILabel = {
        $0.text = "AS 기간 (~"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    let asDateLabel: UILabel = {
        $0.text = "23.01.10)"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    let remainDateLabel: UILabel = {
        $0.text = "152일"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = .blue
        return $0
    }(UILabel())

    private let remainedTextLabel: UILabel = {
        $0.text = "남았어요"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(white: 0, alpha: 0.05)

        addSubview(asTitleLabel)
        asTitleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
        }

        addSubview(asDateLabel)
        asDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalTo(asTitleLabel.snp.right)
        }

        addSubview(remainDateLabel)
        remainDateLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        addSubview(remainedTextLabel)
        remainedTextLabel.snp.makeConstraints {
            $0.left.equalTo(remainDateLabel).inset(10)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
