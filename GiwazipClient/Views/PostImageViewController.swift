//
//  PostImageView.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/25.
//

import UIKit

import SnapKit

class PostImageViewController: BaseViewController {
    
    // MARK: - Property
    
    private let pinch = UIPinchGestureRecognizer(target: self, action: #selector(controlPinch))
    
    // MARK: - View
    
    private let scrollView = UIScrollView()
    
    private lazy var postImage: UIImageView = {
        $0.image = UIImage(named: "cat")
        $0.isUserInteractionEnabled = true
        $0.frame = scrollView.bounds
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    // MARK: - Method
    
    override func attribute() {
        super.attribute()
        setupScrollView()
        view.addGestureRecognizer(pinch)
    }
    
    override func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(postImage)
    }
    
    private func setupScrollView() {
        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    @objc func controlPinch() {
        postImage.transform = postImage.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
}

extension PostImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
         return self.postImage
     }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            guard let image = postImage.image else { return }
            guard let zoomView = viewForZooming(in: scrollView) else { return }
            
            let widthRatio = zoomView.frame.width / image.size.width
            let heightRatio = zoomView.frame.height / image.size.height
            let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
            
            let newWidth = image.size.width * ratio
            let newHeight = image.size.height * ratio
            
            let left = 0.5 * (newWidth * scrollView.zoomScale > zoomView.frame.width ?
                              (newWidth - zoomView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
            let top = 0.5 * (newHeight * scrollView.zoomScale > zoomView.frame.height ? (newHeight - zoomView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
            
            scrollView.contentInset = UIEdgeInsets(top: top.rounded(), left: left.rounded(), bottom: top.rounded(), right: left.rounded())
        } else {
            scrollView.contentInset = .zero
        }
    }
}

