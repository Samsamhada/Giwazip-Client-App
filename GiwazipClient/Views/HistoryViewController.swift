//
//  HistoryViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

import SnapKit

class HistoryViewController: BaseViewController {

    // MARK: - View

    private let historyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    private let microCopy: UILabel = {
        $0.text = "아직 진행 중인 시공이 없습니다."
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.isHidden = true
        return $0
    }(UILabel())

    // MARK: - Method

    override func attribute() {
        super.attribute()

        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self

        historyCollectionView.register(PostDateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PostDateHeader.identifier)
        historyCollectionView.register(ASCell.self, forCellWithReuseIdentifier: ASCell.identifier)
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)

        historyCollectionView.showsVerticalScrollIndicator = false
    }

    override func layout() {
        view.addSubview(historyCollectionView)
        historyCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(microCopy)
        microCopy.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Section

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 5에 게시물 데이터 갯수 반영
        return section == 0 ? 1 : 2
    }

    // MARK: - Header

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        return CGSize(width: screenWidth, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header = UICollectionReusableView()

        if indexPath.section > 0 {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PostDateHeader.identifier, for: indexPath) as! PostDateHeader
            // TODO: - 날짜 데이터 반영
        }

        return header
    }

    // MARK: - Cell

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASCell.identifier, for: indexPath) as! ASCell
            // TODO: - 진행률 반영
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
            // TODO: - 게시물 데이터 반영
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: screenWidth, height: 180)
        }

        return CGSize(width: screenWidth - 32, height: screenWidth / 4 * 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
