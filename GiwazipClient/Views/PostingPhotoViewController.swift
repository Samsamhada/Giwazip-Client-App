//
//  PostingPhotoViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/21.
//

import PhotosUI
import UIKit

import SnapKit

class PostingPhotoViewController: BaseViewController {

    // MARK: - Property

    private var uiButtonConfiguration = UIButton.Configuration.plain()
    private var configuration = PHPickerConfiguration()
    private var isChangedConfigure = false
    private var selectedIndex = 0
    private let emptyImage = UIImage()

    private lazy var images: [UIImage] = [emptyImage] {
        didSet {
            if images.count > 1 {
                // TODO: - 네비게이션 기능 필요.
                nextButton.backgroundColor = .blue
                nextButton.removeTarget(self, action: #selector(showAlert), for: .touchUpInside)
            } else {
                nextButton.backgroundColor = .gray
                nextButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            }
        }
    }

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
        collectionView.contentInset.bottom = 80
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

    func setupPHPickerConfigure() {
        configuration.selection = .ordered
        configuration.selectionLimit = (6 - images.count)
        configuration.filter = .any(of: [.images, .not(.livePhotos)])
    }

    func showPHPicker() {
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension PostingPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingPhotoCell.identifier, for: indexPath) as! PostingPhotoCell

        cell.plusIcon.isHidden = (indexPath.item == 0 && images[0] == emptyImage) ? false : true

        if (images.count == 6) && (images[0] == emptyImage) {
            images.remove(at: 0)
            photoCollectionView.reloadData()
        } else {
            cell.postingImage.image = self.images[indexPath.item]

            if images.count < 5 && !images.contains(emptyImage) {
                images.insert(emptyImage, at: 0)
                photoCollectionView.reloadData()
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let height = width / 4 * 3

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item
        setupPHPickerConfigure()

        // MARK: - ActionSheet

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let changePhoto = UIAlertAction(title: "사진 변경하기", style: .default) { _ in
            self.isChangedConfigure = false
            self.configuration.selectionLimit = 1
            self.configuration.selection = .default

            self.showPHPicker()
            self.images.remove(at: self.selectedIndex)
        }
        let deletePhoto = UIAlertAction(title: "사진 삭제하기", style: .destructive) {
            _ in
            self.photoCollectionView.reloadData()
            self.images.remove(at: self.selectedIndex)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        if (selectedIndex == 0) && (images[0] == emptyImage) {
            self.isChangedConfigure = true
            showPHPicker()
        } else {
            actionSheet.addAction(changePhoto)
            actionSheet.addAction(deletePhoto)
        }
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension PostingPhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true)

        let itemProviders = results.map { $0.itemProvider }

        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        self.images.insert(image,
                                           at: self.isChangedConfigure ? self.selectedIndex + 1 : self.selectedIndex)
                        self.photoCollectionView.reloadData()
                    }
                }
            }
        }
    }
}
