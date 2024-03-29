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

    private let asDateContainer = UIView()

    private let asTitleLabel: UILabel = {
        $0.text = "AS 기간 (~"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    let asDateLabel: UILabel = {
        $0.text = "00.00.00)"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    let remainedDateContainer = UIView()

    let remainedDateLabel: UILabel = {
        $0.text = "000일"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = .blue
        return $0
    }(UILabel())

    private let remainedTextLabel: UILabel = {
        $0.text = TextLiteral.remainText
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

        addSubview(asDateContainer)
        asDateContainer.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
        }

        asDateContainer.addSubview(asTitleLabel)
        asTitleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }

        asDateContainer.addSubview(asDateLabel)
        asDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(asTitleLabel.snp.right)
        }

        addSubview(remainedDateContainer)
        remainedDateContainer.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        remainedDateContainer.addSubview(remainedDateLabel)
        remainedDateLabel.snp.makeConstraints {
            $0.left.verticalEdges.equalToSuperview()
        }

        remainedDateContainer.addSubview(remainedTextLabel)
        remainedTextLabel.snp.makeConstraints {
            $0.left.equalTo(remainedDateLabel.snp.right).offset(10)
            $0.right.verticalEdges.equalToSuperview()
        }
    }
}
