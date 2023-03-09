//
//  PostingPhotoViewController.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/01/21.
//

import PhotosUI
import UIKit

import SnapKit

protocol PostingPhotoViewControllerDelegate {
    
}

class PostingPhotoViewController: BaseViewController {

    // MARK: - Property

    var delegate: PostingPhotoViewControllerDelegate?
    private var buttonConfiguration = UIButton.Configuration.filled()
    private var pickerConfiguration = PHPickerConfiguration()
    private var isChangedPHPickerRole = false
    private var selectedIndex = 0
    private let emptyImage = UIImage()
    private var imageDatas: [Data] = []
    private lazy var images: [UIImage] = [emptyImage] {
        didSet {
            nextButton.isEnabled = (images.count > 1) ? true : false
        }
    }

    // MARK: - View

    private let guidanceLabel: UILabel = {
        $0.text = TextLiteral.guidanceText
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 2
        return $0
    }(UILabel())

    private let photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset.bottom = 20
        return collectionView
    }()

    private lazy var nextButton: UIButton = {
        $0.configuration?.title = TextLiteral.nextButtonText
        $0.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = .blue
        $0.configuration?.background.cornerRadius = 0
        $0.configuration?.contentInsets.bottom = 20
        $0.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        $0.isEnabled = false
        return $0
    }(UIButton(configuration: buttonConfiguration))

    // MARK: - Attribute

    override func attribute() {
        super.attribute()

        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: TextLiteral.cancelButtonText, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .blue
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.title = TextLiteral.navigationTitle
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(PostingPhotoCell.self,
                                     forCellWithReuseIdentifier: PostingPhotoCell.identifier)
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()

        view.addSubview(guidanceLabel)
        guidanceLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.centerX.equalToSuperview()
        }

        view.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(guidanceLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }

        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }

    // MARK: - PHPicker
    
    private func setupPHPickerConfigure() {
        pickerConfiguration.selection = .ordered
        pickerConfiguration.selectionLimit = (6 - images.count)
        pickerConfiguration.filter = .any(of: [.images, .not(.livePhotos)])
    }

    private func showPHPicker() {
        let picker = PHPickerViewController(configuration: pickerConfiguration)
        picker.delegate = self
        present(picker, animated: true)
    }

    private func didTapChangeAction() {
        pickerConfiguration.selectionLimit = 1
        pickerConfiguration.selection = .default
        showPHPicker()
    }
    
    private func didTapDeleteAction() {
        images.remove(at: selectedIndex)
        photoCollectionView.reloadData()
    }

    // MARK: - NextButton Action

    @objc func didTapNextButton() {
        convertImageToData()

        let postingTextViewController = PostingTextViewController()
        postingTextViewController.imageDatas = imageDatas
        navigationController?.pushViewController(postingTextViewController, animated: true)
    }

    private func convertImageToData() {
        imageDatas = []

        for image in images where image != emptyImage {
            imageDatas.append(resizeImage(image: image))
        }
    }

    // MARK: - Image
    
    private func resizeImage(image: UIImage, newSize: CGFloat = 880) -> Data {
        let maxSize = max(image.size.width, image.size.height)

        if maxSize > newSize {
            let scale = newSize / maxSize
            let newWidth = image.size.width * scale
            let newHeight = image.size.height * scale
            
            let size = CGSize(width: newWidth, height: newHeight)
            let render = UIGraphicsImageRenderer(size: size)
            let renderImage = render.jpegData(withCompressionQuality: 1/3, actions: { _ in
                image.draw(in: CGRect(origin: .zero, size: size))
            })
            return renderImage
        }
        return image.jpegData(compressionQuality: 1/3)!
    }

    private func checkAndUploadImage(image: UIImage) {
        if let resizeImage = UIImage(data: resizeImage(image: image)) {
            if (image.size.width < 400) || (image.size.height < 400) {
                makeAlert(message: TextLiteral.minimumSizeAlertMessage)
            } else if (resizeImage.size.width < 400) || (resizeImage.size.height < 400) {
                makeAlert(message: TextLiteral.unnormalSizeAlertMessage)
            } else if isChangedPHPickerRole {
                images.insert(resizeImage, at: selectedIndex + 1)
            } else {
                images[selectedIndex] = resizeImage
            }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PostingPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingPhotoCell.identifier, for: indexPath) as! PostingPhotoCell

        cell.contents.isHidden = (indexPath.item == 0 && images[0] == emptyImage) ? false : true

        if images.count == 6 {
            images.remove(at: 0)
            photoCollectionView.reloadData()
        } else if images.count < 5 && !images.contains(emptyImage) {
            images.insert(emptyImage, at: 0)
            photoCollectionView.reloadData()
        } else {
            cell.postingImage.image = self.images[indexPath.item]
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth - 32
        let height = width / 4 * 3

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.item

        setupPHPickerConfigure()

        if (selectedIndex == 0) && (images[0] == emptyImage) {
            isChangedPHPickerRole = true
            showPHPicker()
        } else {
            makeActionSheet(
                firstContext: TextLiteral.photoChangeText,
                secondContext: TextLiteral.photoDeleteText,
                didTapFirst: { change in
                    self.isChangedPHPickerRole = false
                    self.didTapChangeAction()
                },
                didTapSecond: { delete in
                    self.didTapDeleteAction()
                }
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - PHPickerViewControllerDelegate

extension PostingPhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        dismiss(animated: true)

        let itemProviders = results.map { $0.itemProvider }.reversed()

        for item in itemProviders {
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, _) in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        self.checkAndUploadImage(image: image)
                        self.photoCollectionView.reloadData()
                    }
                }
            }
        }
    }
}
