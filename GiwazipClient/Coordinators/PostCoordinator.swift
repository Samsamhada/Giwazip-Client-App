//
//  PostCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/11.
//

protocol PostCoordinatorDelegate {
    func presentPostImageView()
}

class PostCoordinator: BaseCoordinator, PostViewControllerDelegate {

    let postViewController = PostViewController()

    var delegate: PostCoordinatorDelegate?

    override func start() {
        postViewController.delegate = self
    }

    func presentPostImageView() {
        delegate?.presentPostImageView()
    }
}
