//
//  PostImageCoordinaor.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/11.
//

protocol PostImageCoordinatorDelegate {
    func popToViewController()
}

class PostImageCoordinator: BaseCoordinator, PostImageViewControllerDelegate {

    // MARK: - Property
    
    var delegate: PostImageCoordinatorDelegate?
    
    // MARK: - Method
    
    override func start() {
        let postImageViewController = PostImageViewController()
        postImageViewController.delegate = self

        navigationController.pushViewController(postImageViewController, animated: true)
    }
    
    func popToPostViewController() {
        delegate?.popToViewController()
    }
}
