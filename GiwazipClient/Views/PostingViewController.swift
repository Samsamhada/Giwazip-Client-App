//
//  PostingViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/26.
//

import UIKit

import SnapKit

class PostingViewController: BaseViewController {

    // MARK: - View

    private lazy var imageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = .zero
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemGray4
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()

    private let tempBlock: UIView = {
        $0.backgroundColor = .systemGray4
        return $0
    }(UIView())

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

        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(DetailPostingCell.self, forCellWithReuseIdentifier: DetailPostingCell.identifier)
    }

    override func layout() {
        super.layout()

        view.addSubview(imageCollectionView)
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width / 4 * 3)
        }

        view.addSubview(tempBlock)
        tempBlock.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(UIScreen.main.bounds.width / 6)
        }

        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(tempBlock.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(0.5)
        }

        view.addSubview(postingDescription)
        postingDescription.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(22)
        }
    }
}

extension PostingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 이미지 데이터 갯수
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPostingCell.identifier, for: indexPath) as! DetailPostingCell
        cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 2
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.width / 4 * 3

        return CGSize(width: width, height: height)
    }
}
