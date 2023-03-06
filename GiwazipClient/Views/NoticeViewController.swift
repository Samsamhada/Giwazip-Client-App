//
//  NoticeViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/24.
//

import UIKit

class NoticeViewController: UICollectionViewController {

    // MARK: - Property

    lazy var noticeItems = [
        Notice(noticeID: 1,
               title: "짓다 오픈",
               content: "짓다가 오픈되었습니다~ 와~~~~",
               createDate: "2023-03-06",
               isHidden: false,
               admin: Admin(adminID: 1, name: "미뉴")),
        Notice(noticeID: 2,
               title: "테스트 1번",
               content: "테스트1공지사항입니다.이렇게 엔터도 하구~\n이렇게 띄어쓰기도 해보고~~~\n이렇게 여러 줄로도 한번 써보고 이것 저것 다 해보고 하면서 테스트하는거죠 후후",
               createDate: "2023-03-07",
               isHidden: false,
               admin: Admin(adminID: 2, name: "에디")),
        Notice(noticeID: 3,
               title: "숨김 공지 테스트",
               content: "숨김 공지 테스트 입니다~ 우와~~~~~~ 이게 안보여야 하는데 말이죠~",
               createDate: "2023-03-08",
               isHidden: true,
               admin: Admin(adminID: 1, name: "미뉴"))
    ]

    private enum Section: CaseIterable {
        case noticeList
    }

    private enum NoticeItem: Hashable {
        case title(Notice)
        case content(Notice)
    }

    private let titleCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Notice>
    { cell, indexPath, item in
        var content = cell.defaultContentConfiguration()

        content.text = "\(item.createDate)"
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        content.textProperties.color = .gray

        content.secondaryText = item.title
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 17)

        cell.contentConfiguration = content

        var headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
        headerDisclosureOption.tintColor = .black

        cell.accessories = [.outlineDisclosure(options: headerDisclosureOption)]
    }

    private let contentCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Notice>
    { cell, indexPath, item in
        var content = cell.defaultContentConfiguration()
        
        content.text = item.admin?.name
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        content.textProperties.color = .gray


        content.secondaryText = item.content
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

        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<NoticeItem>()

        for item in noticeItems.reversed() where !item.isHidden {
            let noticeTitle = NoticeItem.title(item)
            sectionSnapshot.append([noticeTitle])

            let noticeContent = NoticeItem.content(item)
            sectionSnapshot.append([noticeContent], to: noticeTitle)
        }

        dataSource.apply(snapshot)
        dataSource.apply(sectionSnapshot, to: .noticeList, animatingDifferences: true)
    }

    // MARK: - CollectionView Method

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
