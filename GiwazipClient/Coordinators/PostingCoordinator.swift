//
//  PostingPhotoCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

import UIKit

protocol PostingPhotoCoordinatorDelegate {
    func dismissViewController()
}

class PostingCoordinator: BaseCoordinator, PostingPhotoViewControllerDelegate {

    // MARK: - Property
    
    var delegate: PostingPhotoCoordinatorDelegate?
    private let postingPhotoViewController = PostingPhotoViewController()
    private let postingTextViewController = PostingTextViewController()
    
    // MARK: - Method
    
    override func start() {
        postingPhotoViewController.delegate = self

        rootViewController = UINavigationController(rootViewController: postingPhotoViewController)
        rootViewController.modalPresentationStyle = .fullScreen

        navigationController.present(rootViewController, animated: true)
    }

    func pushToPostingTextViewController() {
        postingTextViewController.isEditView = false
        postingTextViewController.imageDatas = postingPhotoViewController.imageDatas
        
        rootViewController.pushViewController(postingTextViewController, animated: true)
    }

    func dismissPostingPhotoViewController() {
        delegate?.dismissViewController()
    }
}
