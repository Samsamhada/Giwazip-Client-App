//
//  PostImageView.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/25.
//

import UIKit

import SnapKit

class PostImageViewController: BaseViewController {
    
    // MARK: - View
    
    private lazy var scrollView: UIScrollView = {
        $0.frame = self.view.bounds
        $0.zoomScale = 1.0
        $0.minimumZoomScale = 1.0
        $0.maximumZoomScale = 3.0
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        return $0
    }(UIScrollView())
    
    private lazy var postImage: UIImageView = {
        $0.image = UIImage(named: "cat")
        $0.isUserInteractionEnabled = true
        $0.frame = scrollView.bounds
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    // MARK: - Method
    
    override func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(postImage)
    }
}

extension PostImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.postImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale < 1 {
            scrollView.contentInset = .zero
        } else if scrollView.zoomScale >= 3.0 {
            scrollView.zoomScale = 3.0
        }
    }
}

