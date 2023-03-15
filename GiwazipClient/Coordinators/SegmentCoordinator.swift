//
//  SegmentCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/02.
//

protocol SegmentCoordinatorDelegate {
    func presentPostingView()
    func presentSettingView()
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

    func presentPostingPhotoView() {
        self.delegate?.presentPostingView()
    }
    
    func presentSettingView() {
        self.delegate?.presentSettingView()
    }
}
