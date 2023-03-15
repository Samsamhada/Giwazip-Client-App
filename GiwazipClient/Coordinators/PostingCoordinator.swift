//
//  PostingPhotoCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

import UIKit

import UIKit

protocol PostingPhotoCoordinatorDelegate {
    func dismissPostingView()
}

class PostingCoordinator: BaseCoordinator, PostingPhotoViewControllerDelegate, PostingTextViewControllerDelegate {
    
    var delegate: PostingPhotoCoordinatorDelegate?
    
    override func start() {
        let postingPhotoViewController = PostingPhotoViewController()
        postingPhotoViewController.delegate = self

        rootViewController = UINavigationController(rootViewController: postingPhotoViewController)
        rootViewController.modalPresentationStyle = .fullScreen

        navigationController.present(rootViewController, animated: true)
    }

    func presentPostingTextView() {
        let postingTextViewController = PostingTextViewController()
        postingTextViewController.delegate = self

        rootViewController.pushViewController(postingTextViewController, animated: true)
    }
    
    func popToPostingPhotoView() {
        rootViewController.popViewController(animated: true)
    }
    
    func dismissPostingView() {
        delegate?.dismissPostingView()
    }
}
