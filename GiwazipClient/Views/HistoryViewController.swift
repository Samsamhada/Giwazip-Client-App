//
//  HistoryViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

import SnapKit

class HistoryViewController: BaseViewController {

    // MARK: - Property

    var isWorkView = true
    private var isFirstVisit = true

    // MARK: - View

    private let historyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    private let microCopy: UILabel = {
        $0.text = TextLiteral.emptyWorkHistoryText
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
        historyCollectionView.register(ProgressCell.self, forCellWithReuseIdentifier: ProgressCell.identifier)
        historyCollectionView.register(ASCell.self, forCellWithReuseIdentifier: ASCell.identifier)
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)

        historyCollectionView.showsVerticalScrollIndicator = false
        historyCollectionView.allowsMultipleSelection = true
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

        if section == 0 {
            return isWorkView ? 12 : 1
        }

        return 2
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
        if indexPath.section != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
            // TODO: - 게시물 데이터 반영
            return cell
        } else if isWorkView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCell.identifier, for: indexPath) as! ProgressCell
            // TODO: - 서버에서 가져온 값으로 카테고리 이름 및 진행률 변경
            cell.progress = CGFloat((indexPath.item % 11) * 10)
            cell.categoryName.text = "안방"

            if indexPath.item == 0 && isFirstVisit {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                isFirstVisit.toggle()
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASCell.identifier, for: indexPath) as! ASCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return isWorkView ? CGSize(width: screenWidth/6, height: screenWidth/6) : CGSize(width: screenWidth, height: 180)
        }

        return CGSize(width: screenWidth - 32, height: screenWidth / 4 * 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isWorkView && section == 0 {
            return 0
        }
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (historyCollectionView.indexPathsForSelectedItems ?? [])
            .filter { $0.section == indexPath.section && $0.item != indexPath.item }
            .forEach { self.historyCollectionView.deselectItem(at: $0, animated: false) }
    }
}
