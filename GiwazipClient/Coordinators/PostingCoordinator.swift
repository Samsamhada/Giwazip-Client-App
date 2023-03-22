//
//  PostingPhotoCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

import UIKit

protocol PostingCoordinatorDelegate {
    func dismissViewController()
}

class PostingCoordinator: BaseCoordinator, PostingPhotoViewControllerDelegate, PostingTextCoordinatorDelegate  {
    
    // MARK: - Property
    
    var delegate: PostingCoordinatorDelegate?
    private let postingPhotoViewController = PostingPhotoViewController()
    lazy var rootViewController = UINavigationController(rootViewController: self.postingPhotoViewController)
    
    // MARK: - Method
    
    override func start() {
        postingPhotoViewController.delegate = self
        rootViewController.modalPresentationStyle = .fullScreen
        navigationController.present(rootViewController, animated: true)
    }

    func pushToPostingTextViewController() {
        let coordinator = PostingTextCoordinator(navigationController: rootViewController)
        coordinator.isPostTextView = true
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func popToPostingPhotoViewController() {
        childCoordinators.removeLast()
        rootViewController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        delegate?.dismissViewController()
    }
}
