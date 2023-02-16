//
//  SettingViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/15.
//

import UIKit

private let reuseIdentifier = "Cell"

class SettingViewController: UICollectionViewController {

    // MARK: - Property

    private let settingList = [["📝 고객 정보 수정"],
                               ["📢 공지사항", "📄 이용약관", "🧑🏼‍💻 개발자 정보", "☕️ 오픈소스 라이브러리", "📬 고객센터", "📱 버전 정보"],
                               ["🔚 시공 마감하기"]]

    private enum Section: CaseIterable {
        case userSetting
        case appSetting
        case roomSetting
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, String> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>
        { cell, indexPath, setting in
            var content = cell.defaultContentConfiguration()
            content.text = setting

            if indexPath.section == 2 {
                content.textProperties.color = .red
            }

            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        }

        return UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView)
        { (collectionView, indexPath, setting) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: setting)
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isScrollEnabled = false
        applySnapshot(animatingDifferences: false)
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()

        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(settingList[0], toSection: .userSetting)
        snapshot.appendItems(settingList[1], toSection: .appSetting)
        snapshot.appendItems(settingList[2], toSection: .roomSetting)

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let setting = dataSource.itemIdentifier(for: indexPath) {
            // TODO: - 각 항목 선택별 이벤트
            print("\(setting) 항목 선택")
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
