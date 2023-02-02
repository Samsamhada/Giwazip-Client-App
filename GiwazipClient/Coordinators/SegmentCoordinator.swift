//
//  SegmentCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

import Foundation

protocol SegmentCoordinatorDelegate {
    func presentPostingPhotoView(_ coordinator: SegmentCoordinator)
}

class SegmentCoordinator: BaseCoordinator, SegmentViewControllerDelegate {

    var delegate: SegmentCoordinatorDelegate?

    override func start() {
        let segmentViewController = SegmentViewController()
        segmentViewController.delegate = self

        navigationController.viewControllers = [segmentViewController]
    }

    func presentPostingPhotoView() {
        self.delegate?.presentPostingPhotoView(self)
    }
}
