//
//  PostingPhotoCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

import UIKit

class PostingPhotoCoordinator: BaseCoordinator, PostingPhotoViewControllerDelegate {
    override func start() {
        let postingPhotoViewController = PostingPhotoViewController()
        postingPhotoViewController.delegate = self

        let navigationController = UINavigationController(rootViewController: postingPhotoViewController)
        navigationController.modalPresentationStyle = .fullScreen

        self.navigationController.present(navigationController, animated: true)
    }
}
