//
//  PostingTextView.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/16.
//

import UIKit

protocol PostingTextCoordinatorDelegate {
    func dismissViewController()
    func popToPostingPhotoViewController()
}

class PostingTextCoordinator: BaseCoordinator, PostingTextViewControllerDelegate {

    // MARK: - Property
    
    var delegate: PostingTextCoordinatorDelegate?
    var isPostTextView: Bool?

    // MARK: - Method
    
    override func start() {
        let postingTextViewController = PostingTextViewController()
        postingTextViewController.delegate = self
        postingTextViewController.isPostTextView = isPostTextView!
        
        if isPostTextView! {
            navigationController.pushViewController(postingTextViewController, animated: true)
        } else {
            let rootViewController = UINavigationController(rootViewController: postingTextViewController)
            rootViewController.modalPresentationStyle = .fullScreen

            navigationController.present(rootViewController, animated: true)
        }
    }
    
    func popToPostingPhotoViewController() {
        delegate?.popToPostingPhotoViewController()
    }

    
    func dismissPostingTextViewController() {
        delegate?.dismissViewController()
    }
    
    func dismissEditingTextViewController() {
        navigationController.dismiss(animated: true)
    }
}
