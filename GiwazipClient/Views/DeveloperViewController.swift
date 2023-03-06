//
//  DeveloperViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/23.
//

import SafariServices
import UIKit

import Alamofire

struct Developer: Hashable {
    let nickname: String
    let name: String
    let github: String
}

class DeveloperViewController: UICollectionViewController {

    // MARK: - Property

    private enum Section: CaseIterable {
        case meenu
        case eddy
        case dinner

        func loadDeveloperInfo() -> [Developer] {
            switch self {
            case .meenu:
                return [.init(nickname: TextLiteral.meenuNickname, name: TextLiteral.meenuName, github: TextLiteral.meenuGithub)]
            case .eddy:
                return [.init(nickname: TextLiteral.eddyNickname, name: TextLiteral.eddyName, github: TextLiteral.eddyGithub)]
            case .dinner:
                return [.init(nickname: TextLiteral.dinnerNickname, name: TextLiteral.dinnerName, github: TextLiteral.dinnerGithub)]
            }
        }
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Developer> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Developer>
        { cell, indexPath, item in
            var content = cell.defaultContentConfiguration()
            
            content.text = item.nickname

            content.secondaryText = item.name
            content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14)
            content.secondaryTextProperties.color = .gray

            cell.contentConfiguration = content

            let githubLogoView = UIImageView(image: ImageLiteral.githubLogo)
            githubLogoView.contentMode = .scaleAspectFit

            var customAccessory = UICellAccessory.CustomViewConfiguration(customView: githubLogoView, placement: .trailing(displayed: .always))
            cell.accessories = [.customView(configuration: customAccessory)]
        }

        return UICollectionViewDiffableDataSource<Section, Developer>(collectionView: collectionView)
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applySnapshot(animatingDifferences: false)
    }

    // MARK: - Method

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Developer>()

        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach {
            snapshot.appendItems($0.loadDeveloperInfo(), toSection: $0)
        }

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    // MARK: - CollectionView Method

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            if let url = URL(string: item.github) {
                let githubProfile = SFSafariViewController(url: url)
                present(githubProfile, animated: true)
            }
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
