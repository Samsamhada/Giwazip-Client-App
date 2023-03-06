//
//  NoticeViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/24.
//

import UIKit

struct NoticeTitle: Hashable {
    let title: String
    let createDate: String
    let content: NoticeContent
}

struct NoticeContent: Hashable {
    let description: String
    let author: String
}

class NoticeViewController: UICollectionViewController {

    // MARK: - Property

    lazy var noticeItems = [
        NoticeTitle(title: "테스트1",
                    createDate: "2023-02-23",
                    content: NoticeContent(description: "테스트1입니다\n테스트1입니다\n테스트1입니다\n테스트1입니다\n테스트1입니다", author: "관리자 1")),
        NoticeTitle(title: "테스트2",
                    createDate: "2023-02-24",
                    content: NoticeContent(description: "테스트2입니다", author: "관리자 2"))
    ]

    private enum Section: CaseIterable {
        case noticeList
    }

    private enum NoticeItem: Hashable {
        case title(NoticeTitle)
        case content(NoticeContent)
    }

    private let titleCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, NoticeTitle>
    { cell, indexPath, item in
        var content = cell.defaultContentConfiguration()

        content.text = item.title

        content.secondaryText = item.createDate
        content.secondaryTextProperties.color = .gray

        cell.contentConfiguration = content

        let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
        cell.accessories = [.outlineDisclosure(options: headerDisclosureOption)]
    }

    private let contentCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, NoticeContent>
    { cell, indexPath, item in
        var content = cell.defaultContentConfiguration()
        
        content.text = item.author
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        content.textProperties.color = .gray

        content.secondaryText = item.description
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)

        cell.contentConfiguration = content
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, NoticeItem> = {

        return UICollectionViewDiffableDataSource<Section, NoticeItem>(collectionView: collectionView)
        { (collectionView, indexPath, item) in
            switch item {
            case .title(let title):
                return collectionView.dequeueConfiguredReusableCell(using: self.titleCellRegistration,
                                                                    for: indexPath,
                                                                    item: title)
            case .content(let content):
                return collectionView.dequeueConfiguredReusableCell(using: self.contentCellRegistration,
                                                                    for: indexPath,
                                                                    item: content)
            }
        }
    }()

    // MARK: - Life Cycle

    init() {
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .plain)))
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applySnapshot(animatingDifferences: false)
    }

    // MARK: - Method

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, NoticeItem>()

        snapshot.appendSections(Section.allCases)

        dataSource.apply(snapshot)

        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<NoticeItem>()

        for item in noticeItems.reversed() {
            let noticeTitle = NoticeItem.title(item)
            sectionSnapshot.append([noticeTitle])

            let noticeContent = NoticeItem.content(item.content)
            sectionSnapshot.append([noticeContent], to: noticeTitle)
        }

        dataSource.apply(sectionSnapshot, to: .noticeList, animatingDifferences: true)
    }

    // MARK: - CollectionView Method

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
