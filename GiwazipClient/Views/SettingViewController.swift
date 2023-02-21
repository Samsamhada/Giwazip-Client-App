//
//  SettingViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/15.
//

import MessageUI
import SafariServices
import UIKit

class SettingViewController: UICollectionViewController {

    // MARK: - Property

    private let settingItems = TextLiteral.settingItems

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

            if item == "버전 정보" {
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

    func openCustomerServiceCenter() {
        if !MFMailComposeViewController.canSendMail() {
            makeAlert(title: TextLiteral.customerServiceErrorTitle, message: TextLiteral.customerServiceErrorMessage)
            return
        }

        let customerServiceMail = MFMailComposeViewController()
        customerServiceMail.mailComposeDelegate = self

        customerServiceMail.setToRecipients(TextLiteral.customerServiceEmail)
        customerServiceMail.setSubject(TextLiteral.customerServiceMailSubject)
        customerServiceMail.setMessageBody(TextLiteral.customerServiceMailBody, isHTML: false)

        self.present(customerServiceMail, animated: true)
    }

    // MARK: - UICollectionView Method

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource.itemIdentifier(for: indexPath) {
            // TODO: - 각 항목 선택별 이벤트
            switch item {
            case settingItems[1][1]:
                if let url = URL(string: TextLiteral.termsConditionURL) {
                    let termsCondition = SFSafariViewController(url: url)
                    present(termsCondition, animated: true)
                }
            case settingItems[1][2]:
                if let url = URL(string: TextLiteral.privacyPolicyURL) {
                    let privacyPolicy = SFSafariViewController(url: url)
                    present(privacyPolicy, animated: true)
                }
            case settingItems[1][5]:
                openCustomerServiceCenter()
            default:
                print("\(item) 항목 선택")
            }
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
