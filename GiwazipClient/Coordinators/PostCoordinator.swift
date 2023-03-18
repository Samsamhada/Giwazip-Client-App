//
//  PostCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/11.
//

protocol PostCoordinatorDelegate {
    func pushToPostImageViewController()
    func presentEditingTextView()
}

class PostCoordinator: BaseCoordinator, PostViewControllerDelegate {

    var delegate: PostCoordinatorDelegate?

    override func start() {
        let postViewController = PostViewController()
        postViewController.delegate = self
        
        navigationController.pushViewController(postViewController, animated: true)
    }

    func pushToPostImageViewController() {
        delegate?.pushToPostImageViewController()
    }
    
    func presentEditingTextViewController() {
        delegate?.presentEditingTextView()
    }
}
