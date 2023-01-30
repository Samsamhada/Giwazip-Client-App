
//  PostViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/26.
//

import UIKit

import SnapKit

class PostViewController: BaseViewController {

    // MARK: - Property

    private let screenWidth = UIScreen.main.bounds.width
    private var selectedIndex = 0 {
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
                                     height: round(screenWidth / 4 * 3))
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    private lazy var thumbnailCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = .zero
        flowLayout.itemSize = CGSize(width: round(screenWidth / 6),
                                     height: round(screenWidth / 6))

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        return collectionView
    }()

    private let divider: UIView = {
        $0.backgroundColor = .systemGray2
        return $0
    }(UIView())

    private let descriptionScroll: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private let postingDescription: UILabel = {
        $0.text =
  """
  - 방황하여도, 인간의 풍부하게 보는 새 피다. 든 바이며, 낙원을 스며들어 생의 싹이 트고, 피다. 있을 못할 꽃이 이상의 심장의 목숨을 봄바람이다. 인간의 동력은 이 고행을 심장의 얼마나 그들의 것이다. 커다란 때까지 설레는 가치를 새 눈이 방황하였으며, 사막이다. 하는 인도하겠다는 넣는 하였으며, 설산에서 것이다. 피고 사는가 전인 일월과 것이 간에 방황하여도, 청춘의 그리하였는가? 시들어 사라지지 이 운다. 인간의 구하기 눈에 우리 영원히 보는 전인 곳으로 있다.

  - 피부가 예가 역사를 그들을 날카로우나 꾸며 위하여서. 작고 무엇을 싸인 구하지 힘차게 이상이 열락의 끓는다. 아름답고 목숨을 석가는 남는 구할 인간이 동력은 얼음 것이다.보라, 이것이다. 기관과 충분히 이 원질이 주는 피에 우리의 운다. 할지라도 풍부하게 그들은 철환하였는가? 행복스럽고 것이 따뜻한 돋고, 천자만홍이 사람은 있다. 가치를 돋고, 가슴이 품었기 피고 싹이 때문이다. 수 같이, 이것은 인생에 운다. 청춘 가치를 인간은 주는 싸인 영원히 보라. 품에 실로 없는 위하여, 더운지라 무엇을 꽃이 대한 운다.
  """
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = .zero
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return $0
    }(UILabel())

    // MARK: - Method

    override func attribute() {
        super.attribute()

        setupCollectionView(at: imageCollectionView, cell: PostCell.self, identifier: PostCell.identifier)
        setupCollectionView(at: thumbnailCollectionView, cell: PostCell.self, identifier: PostCell.identifier)
        setupNavigation()
    }

    override func layout() {
        super.layout()

        view.addSubview(imageCollectionView)
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(round(screenWidth / 4 * 3))
        }

        view.addSubview(thumbnailCollectionView)
        thumbnailCollectionView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(round(screenWidth / 6))
        }

        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(thumbnailCollectionView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(0.5)
        }

        view.addSubview(descriptionScroll)
        descriptionScroll.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        descriptionScroll.addSubview(postingDescription)
        postingDescription.snp.makeConstraints {
            $0.top.horizontalEdges.width.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    private func setupCollectionView(at collectionView: UICollectionView, cell: AnyClass, identifier: String) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }

    private func setupNavigation() {
        let navigationRightItem = UIBarButtonItem(title: "수정",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(didTapEditButton))
        navigationItem.rightBarButtonItem = navigationRightItem
    }

    @objc func didTapEditButton() {
        print("didTapEditButton is no error")
    }
}

extension PostViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 이미지 데이터 갯수
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as! PostCell

        cell.whiteBlock.isHidden = true

        if collectionView == thumbnailCollectionView {
            if selectedIndex == indexPath.item {
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 3
            } else {
                cell.layer.borderWidth = 0
                cell.whiteBlock.isHidden = false
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        imageCollectionView.scrollToItem(at: indexPath,
                                         at: .centeredHorizontally,
                                         animated: true)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / scrollView.frame.width
        selectedIndex = Int(ceil(pageNumber))
    }
}
