//
//  SettingViewController.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/02/15.
//

import MessageUI
import SafariServices
import UIKit

protocol SettingContentDelegate {
    func popToSettingView()
}

protocol SettingViewControllerDelegate {
    func presentClientInfoView()
    func presentNoticeView()
    func presentDeveloperView()
    func presentLicenseView()
    func popToSegmentView()
}

class SettingViewController: BaseViewController {

    var delegate: SettingViewControllerDelegate?
    static let sectionFooterElementKind = "section-footer-element-kind"
    private let backButton = UIButton()

    private enum Section: CaseIterable {
        case userSetting
        case appSetting
        case roomSetting

        func loadSectionItems() -> [String] {
            switch self {
            case .userSetting:
                return TextLiteral.settingItems[0]
            case .appSetting:
                return TextLiteral.settingItems[1]
            case .roomSetting:
                return TextLiteral.settingItems[2]
            }
        }
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
    private lazy var collectionView: UICollectionView! = nil

    override func layout() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        configureDataSource()
    }
    
    override func attribute() {
        navigationItem.leftBarButtonItem = backBarButton(#selector(didTapBackButton))
    }
    
    @objc func didTapBackButton() {
        delegate?.popToSegmentView()
    }
}

extension SettingViewController {

    // MARK: - CollectionViewLayout

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { index, environment in

            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)

            configuration.footerMode = .supplementary

            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(0))
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: SettingViewController.sectionFooterElementKind, alignment: .bottom)
            section.boundarySupplementaryItems = [sectionFooter]

            return section
        }

        return layout
    }

    func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>
        { (cell, indexPath, item) in
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

        let footerRegistration = UICollectionView.SupplementaryRegistration<SettingFooter>(elementKind: SettingViewController.sectionFooterElementKind)
        { (footer, string, indexPath) in
            if indexPath.section == 2 {
                footer.label.text = "Copyrights 2023. Samsamhada All rights reversed."
            }
        }

        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) {
            (collectionView, indexPath, item) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        dataSource.supplementaryViewProvider = { (collectionView, kind, index) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()

        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach {
            snapshot.appendItems($0.loadSectionItems(), toSection: $0)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // TODO: - 각 항목별 선택 이벤트

        switch (indexPath.section, indexPath.item) {
        case (0, 0):
            delegate?.presentClientInfoView()
        case (1, 0):
            delegate?.presentNoticeView()
        case (1, 1):
            if let url = URL(string: TextLiteral.termsConditionURL) {
                let termsCondition = SFSafariViewController(url: url)
                present(termsCondition, animated: true)
            }
        case (1, 2):
            if let url = URL(string: TextLiteral.privacyPolicyURL) {
                let privacyPolicy = SFSafariViewController(url: url)
                present(privacyPolicy, animated: true)
            }
        case (1, 3):
            delegate?.presentDeveloperView()
        case (1, 4):
            delegate?.presentLicenseView()
        case (1, 5):
            openCustomerServiceCenter()
        case (1, 6):
            // TODO: - 버전 정보
            break
        case (2, 0):
            // TODO: - 시공 마감하기
            break
        default:
            break
        }

        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {

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

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
