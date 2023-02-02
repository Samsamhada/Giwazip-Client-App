//
//  HistoryViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

import SnapKit

class HistoryViewController: BaseViewController {

    // MARK: - View

    private let historyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    private let microCopy: UILabel = {
        $0.text = "아직 진행 중인 시공이 없습니다."
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.isHidden = true
        return $0
    }(UILabel())

    private lazy var inquiryButton: UIButton = {
        $0.configuration?.title = "문의하기"
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .blue
        $0.configuration?.background.cornerRadius = 0
        $0.configuration?.contentInsets.bottom = 20
        return $0
    }(UIButton(configuration: buttonConfiguration))

    // MARK: - Method

    override func attribute() {
        super.attribute()
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        historyCollectionView.register(ASCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ASCell.identifier)
        historyCollectionView.register(PostDateCell.self, forCellWithReuseIdentifier: PostDateCell.identifier)
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
        
        historyCollectionView.showsVerticalScrollIndicator = false
    }
    
    override func layout() {
        view.addSubview(historyCollectionView)
        historyCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(microCopy)
        microCopy.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 게시물 데이터 반영
        return 5
    }
    
    // MARK: - Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ASCell.identifier, for: indexPath) as! ASCell
        // TODO: - 진행률 반영
        return header
    }
    
    // MARK: - Cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDateCell.identifier, for: indexPath) as! PostDateCell
            // TODO: - 날짜 데이터 반영
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
            // TODO: - 게시물 데이터 반영
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: screenWidth, height: 20)
        }
        return CGSize(width: screenWidth, height: screenWidth / 4 * 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
