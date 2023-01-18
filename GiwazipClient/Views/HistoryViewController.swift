//
//  HistoryViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/18.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func attribute() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ProgressHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProgressHeader.identifier)
        collectionView.register(PostDateCell.self, forCellWithReuseIdentifier: PostDateCell.identifier)
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
        
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func layout() {
        view.addSubview(collectionView)
        view.addSubview(microCopy)
        
        collectionView.snp.makeConstraints {
            $0.top.left.bottom.right.equalTo(view)
        }
        
        microCopy.snp.makeConstraints {
            $0.center.equalTo(view.center)
        }
    }
    
}
extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Section
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 게시물 데이터 반영
        return 5
    }
    
    // MARK: - Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProgressHeader.identifier, for: indexPath) as! ProgressHeader
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
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 4 * 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
