
//  PostingViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/26.
//

import UIKit

import SnapKit

class PostingViewController: BaseViewController {

    // MARK: - Property

    let screenWidth = UIScreen.main.bounds.width
    var selectedIndex = 0 {
        didSet {
            imageCollectionView.reloadData()
            thumbnailCollectionView.reloadData()
        }
    }
    
    // MARK: - View

    private lazy var imageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = .zero
        flowLayout.itemSize = CGSize(width: screenWidth,
                                     height: screenWidth / 4 * 3)
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var thumbnailCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        flowLayout.itemSize = CGSize(width: screenWidth / 6,
                                     height: screenWidth / 6)

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        return collectionView
    }()

    private let divider: UIView = {
        $0.backgroundColor = .systemGray2
        return $0
    }(UIView())

    private let postingDescription: UILabel = {
        $0.text = """
                  - testText입니다
                  - testText입니다
                  - testText입니다
                  """
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.backgroundColor = .systemGray4
        return $0
    }(UILabel())

    // MARK: - Method

    override func attribute() {
        super.attribute()

        setupCollectionView()
        setupNavigation()
    }

    override func layout() {
        super.layout()

        view.addSubview(imageCollectionView)
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(screenWidth / 4 * 3)
        }

        view.addSubview(thumbnailCollectionView)
        thumbnailCollectionView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(screenWidth / 6)
        }

        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(thumbnailCollectionView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(0.5)
        }

        view.addSubview(postingDescription)
        postingDescription.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(22)
        }
    }

    private func setupCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(DetailPostingCell.self, forCellWithReuseIdentifier: DetailPostingCell.identifier)
        
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
        thumbnailCollectionView.register(DetailPostingCell.self, forCellWithReuseIdentifier: DetailPostingCell.identifier)
    }

    private func setupNavigation() {
        let navigationRightItem = UIBarButtonItem(title: "수정",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(didTapEditButton))
        self.navigationItem.rightBarButtonItem = navigationRightItem
    }

    @objc func didTapEditButton() {
        print("didTapEditButton is no error")
    }
}

extension PostingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 이미지 데이터 갯수
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPostingCell.identifier, for: indexPath) as! DetailPostingCell

        if (collectionView == thumbnailCollectionView) && (selectedIndex == indexPath.item) {
            cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.borderWidth = 3
            imageCollectionView.scrollToItem(at: indexPath,
                                             at: .centeredHorizontally,
                                             animated: true)
        }
        if selectedIndex != indexPath.item { cell.layer.borderWidth = 0 }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / scrollView.frame.width
        selectedIndex = Int(ceil(pageNumber))
    }
}
