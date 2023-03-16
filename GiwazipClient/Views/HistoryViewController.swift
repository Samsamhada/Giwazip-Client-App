//
//  HistoryViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

import Alamofire
import SnapKit

class HistoryViewController: BaseViewController {

    // MARK: - Property

    static let sectionHeaderElementKind = "section-header-element-kind"

    var isWorkView = true
    private var selectedCategoryID = 1

    private var postSections = Set<String>() {
        didSet {
            microCopy.isHidden = !postSections.isEmpty
            postCollectionView.isScrollEnabled = !postSections.isEmpty
        }
    }

    private lazy var categorySectionHeight = isWorkView ? screenWidth / 6 * Double((networkManager.roomData!.categories!.filter({ $0.name != "문의" }).count - 1) / 6 + 1) : screenWidth/3

    private enum CollectionViewType {
        case category
        case post
    }

    private var categoryDataSource: UICollectionViewDiffableDataSource<String, Category>!
    private var postDataSource: UICollectionViewDiffableDataSource<String, Post>!

    // MARK: - View

    private let topContainerView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())

    private var categoryCollectionView: UICollectionView!
    private var postCollectionView: UICollectionView!

    private let asView = ASView()

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
        categoryCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: categorySectionHeight), collectionViewLayout: createCollectionViewLayout(.category))
        postCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout(.post))

        configureDataSource()
        if isWorkView {
            applyCategorySnapshot()
        } else {
            let asDate = extractDate(networkManager.roomData!.endDate, networkManager.roomData!.warrantyTime)
            asView.asDateLabel.text = asDate + ")"
            asView.remainDateLabel.text = extractRemainDate(asDate) + "일"
        }
        applyPostSnapshot()

        categoryCollectionView.isScrollEnabled = false
        categoryCollectionView.delegate = self
        postCollectionView.delegate = self
    }

    override func layout() {
        view.addSubview(postCollectionView)
        postCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(categorySectionHeight + 3)
        }

        if isWorkView {
            topContainerView.addSubview(categoryCollectionView)
            categoryCollectionView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(2)
                $0.horizontalEdges.bottom.equalToSuperview()
            }
        } else {
            topContainerView.addSubview(asView)
            asView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }

        view.addSubview(microCopy)
        microCopy.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        postCollectionView.contentInset.top = categorySectionHeight + 16

        if !isWorkView {
            postCollectionView.contentInset.bottom = 90
        }

        categoryCollectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .init())
        categoryCollectionView.backgroundColor = UIColor(white: 0, alpha: 0.05)
    }

    private func extractRemainDate(_ asDateText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = TimeZone(identifier: "KST")

        guard let asDate = dateFormatter.date(from: "20" + asDateText) else { return "N/A" }

        let interval = asDate.timeIntervalSince(Date())
        let days = String(Int(interval / 86400))

        return days
    }
}

extension HistoryViewController {

    private func createCollectionViewLayout(_ collectionViewType: CollectionViewType) -> UICollectionViewLayout {
        let sectionProvider = {
            (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let section: NSCollectionLayoutSection

            if collectionViewType == .category {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.screenWidth/6), heightDimension: .absolute(self.screenWidth/6))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(self.screenWidth/6))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 6)

                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.screenWidth), heightDimension: .absolute(self.screenWidth/4*3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(self.screenWidth/4*3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: HistoryViewController.sectionHeaderElementKind, alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
            }

            return section
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }

    private func configurePostSection() {
        switch isWorkView {
        case true:
            if selectedCategoryID == 1 {
                for section in networkManager.roomData!.posts!.filter({ $0.category?.name != "문의" }) {
                    postSections.insert(extractDate(section.createDate))
                }
            } else {
                for section in networkManager.roomData!.posts!.filter({ $0.category?.categoryID == selectedCategoryID }) {
                    postSections.insert(extractDate(section.createDate))
                }
            }
        case false:
            for section in networkManager.roomData!.posts!.filter({ $0.category?.name == "문의" }) {
                postSections.insert(extractDate(section.createDate))
            }
        }
    }

    private func configureDataSource() {
        let categoryCellRegistration = UICollectionView.CellRegistration<ProgressCell, Category> {
            (cell, indexPath, item) in
            if indexPath.item == 0 {
                cell.categoryName.text = "전체"
                cell.progress = self.networkManager.roomData!.categories!.filter({ $0.name != "문의" }).map({ Double($0.progress!)! }).reduce(0, +) / Double(self.networkManager.roomData!.categories!.filter({ $0.name != "문의" }).count)
            } else {
                cell.categoryName.text = item.name
                cell.progress = Double(item.progress!)!
            }
        }

        let postCellRegistration = UICollectionView.CellRegistration<HistoryCell, Post> {
            (cell, indexPath, item) in
            if self.isWorkView, self.selectedCategoryID == 1 {
                cell.chipLabel.text = item.category?.name
            } else {
                cell.chipFrame.isHidden = true
            }
            cell.postDescription.text = item.description

            AF.request(item.photos[0].url, method: .get).response{ response in
                switch response.result {
                case .success(let responseData):
                    cell.postImage.image = UIImage(data: responseData!)
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
        }

        let postDateHeaderRegistration = UICollectionView.SupplementaryRegistration<PostDateHeader>(elementKind: HistoryViewController.sectionHeaderElementKind) {
            (header, kind, indexPath) in
            header.postingDate.text = self.postSections.sorted().reversed()[indexPath.section]
        }

        categoryDataSource = UICollectionViewDiffableDataSource<String, Category>(collectionView: categoryCollectionView) {
            (collectionView, indexPath, item) in
            return collectionView.dequeueConfiguredReusableCell(using: categoryCellRegistration, for: indexPath, item: item)
        }

        postDataSource = UICollectionViewDiffableDataSource<String, Post>(collectionView: postCollectionView) {
            (collectionView, indexPath, item) in
            return collectionView.dequeueConfiguredReusableCell(using: postCellRegistration, for: indexPath, item: item)
        }

        postDataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: postDateHeaderRegistration, for: indexPath)
        }
    }

    private func applyCategorySnapshot() {
        var snapshot = categoryDataSource.snapshot()
        snapshot.appendSections(["categories"])
        snapshot.appendItems(networkManager.roomData!.categories!)

        categoryDataSource.apply(snapshot)
    }

    private func applyPostSnapshot() {
        var snapshot = postDataSource.snapshot()
        snapshot.deleteSections(Array(postSections))
        postSections = []

        configurePostSection()

        snapshot.appendSections(postSections.sorted().reversed())

        switch isWorkView {
        case true:
            if selectedCategoryID == 1 {
                for item in networkManager.roomData!.posts!.filter({ $0.category!.name != "문의" }).reversed() {
                    snapshot.appendItems([item], toSection: extractDate(item.createDate))
                }
            } else {
                for item in networkManager.roomData!.posts!.filter({ $0.category!.categoryID == selectedCategoryID }).reversed() {
                    snapshot.appendItems([item], toSection: extractDate(item.createDate))
                }
            }
        case false:
            for item in networkManager.roomData!.posts!.filter({ $0.category?.name == "문의" }).reversed() {
                snapshot.appendItems([item], toSection: extractDate(item.createDate))
            }
        }

        snapshot.reloadSections(postSections.sorted().reversed())
        postDataSource.applySnapshotUsingReloadData(snapshot)
    }
}

extension HistoryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView, selectedCategoryID != networkManager.roomData!.categories![indexPath.item].categoryID {
            selectedCategoryID = networkManager.roomData!.categories![indexPath.item].categoryID

            applyPostSnapshot()
        } else {
            print("현재 클릭된 부분은 게시물의 \(indexPath)입니다.")
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y

        UIView.animate(withDuration: 0.5) {
            if currentOffset > -self.categorySectionHeight {
                self.topContainerView.alpha = 0
            } else {
                self.topContainerView.alpha = 1
            }
        }
    }
}
