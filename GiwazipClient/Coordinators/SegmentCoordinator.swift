//
//  SegmentCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

protocol SegmentCoordinatorDelegate {
    func presentPostingView()
    func pushToSettingViewController()
    func pushToPostViewController()
}

class SegmentCoordinator: BaseCoordinator, SegmentViewControllerDelegate {

    // MARK: - Property
    
    var delegate: SegmentCoordinatorDelegate?

    // MARK: - Method
    
    override func start() {
        let segmentViewController = SegmentViewController()
        segmentViewController.delegate = self

        navigationController.pushViewController(segmentViewController, animated: true)
    }

    func presentPostingPhotoViewController() {
        self.delegate?.presentPostingView()
    }

    func pushToSettingViewController() {
        self.delegate?.pushToSettingViewController()
    }

    func pushToPostViewController() {
        delegate?.pushToPostViewController()
    }
}
