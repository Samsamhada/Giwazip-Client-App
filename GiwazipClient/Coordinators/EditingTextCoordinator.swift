//
//  PostingTextView.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/16.
//

import UIKit

protocol EditingTextCoordinatorDelegate {
    func dismissViewController()
}

class EditingTextCoordinator: BaseCoordinator, EditingTextViewControllerDelegate {

    var delegate: EditingTextCoordinatorDelegate?

    override func start() {
        let postingTextViewController = PostingTextViewController()
        let postViewController = PostViewController()
        
        postingTextViewController.delegate = self
        
        postingTextViewController.textView.text = postViewController.postingDescription.text
        postingTextViewController.isEditView = true
//
        rootViewController = UINavigationController(rootViewController: postingTextViewController)
        rootViewController.modalPresentationStyle = .fullScreen

        navigationController.present(rootViewController, animated: true)
    }
    
    func dismissPostingTextViewController() {
        delegate?.dismissViewController()
    }
    
    func dismissEditingTextViewController() {
        delegate?.dismissViewController()
    }
}