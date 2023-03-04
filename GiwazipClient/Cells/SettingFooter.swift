//
//  SettingFooter.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/03/05.
//

import SnapKit

class SettingFooter: UICollectionReusableView {

    // MARK: - View

    let label: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.textAlignment = .center
        return $0
    }(UILabel())

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Method

    func setupCell() {
        addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
