//
//  SettingViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/15.
//

import UIKit

class SettingViewController: UICollectionViewController {

    // MARK: - Property

    private let settingItems = [["고객 정보 수정"],
                                ["공지사항", "이용약관", "개발자 정보", "오픈소스 라이브러리", "고객센터", "버전 정보"],
                                ["시공 마감하기"]]

    private enum Section: CaseIterable {
        case userSetting
        case appSetting
        case roomSetting
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, String> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>
        { cell, indexPath, item in
            var content = cell.defaultContentConfiguration()
            
            content.text = item

            if indexPath.section == 1, indexPath.item == 5 {
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                content.secondaryText = version
                content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
                content.secondaryTextProperties.color = .gray
            }

            content.prefersSideBySideTextAndSecondaryText = true

            if indexPath.section == 2 {
                content.textProperties.color = .red
            }

            cell.contentConfiguration = content
        }

        return UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView)
        { (collectionView, indexPath, item) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: item)
        }
    }()

    // MARK: - Life Cycle

    init() {
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .insetGrouped)))
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isScrollEnabled = false
        applySnapshot(animatingDifferences: false)
    }

    // MARK: - Method

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()

        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(settingItems[0], toSection: .userSetting)
        snapshot.appendItems(settingItems[1], toSection: .appSetting)
        snapshot.appendItems(settingItems[2], toSection: .roomSetting)

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    // MARK: - UICollectionView Method

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            // TODO: - 각 항목 선택별 이벤트
            print("\(item) 항목 선택")
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
