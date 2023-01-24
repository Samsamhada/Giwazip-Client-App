//
//  PostingPhotoViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/21.
//

import UIKit

import SnapKit

class PostingPhotoViewController: BaseViewController {
    
    private var uiButtonConfiguration = UIButton.Configuration.plain()
    // MARK: - View
    
    private let guidanceLabel: UILabel = {
        $0.text = """
                  문의할 사진을 추가해주세요.
                  (최대 5장까지 선택 가능합니다.)
                  """
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()

    private lazy var nextButton: UIButton = {
        $0.configuration?.title = "다음"
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.contentInsets.bottom = 20
        $0.backgroundColor = .gray
        $0.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return $0
    }(UIButton(configuration: uiButtonConfiguration))

    // MARK: - Method

    override func attribute() {
        super.attribute()

        setupCollectionView()
    }

    func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(PostingPhotoCell.self,
                                     forCellWithReuseIdentifier: PostingPhotoCell.identifier)
    }
    
    override func layout() {
        super.layout()

        view.addSubview(guidanceLabel)
        guidanceLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.centerX.equalToSuperview()
        }

        view.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(guidanceLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }

        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
}

extension PostingPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - 이미지 갯수
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingPhotoCell.identifier, for: indexPath) as! PostingPhotoCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 32
        let height = width / 4 * 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
