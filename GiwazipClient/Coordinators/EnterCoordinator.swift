//
//  EnterCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol EnterCoordinatorDelegate {
    func pushToSegmentViewController()
    func popToViewController()
}

class EnterCoordinator: BaseCoordinator, EnterViewControllerDelegate, SettingContentDelegate {
    
    var delegate: EnterCoordinatorDelegate?
    let enterViewController = EnterViewController()
    
    override func start() {
        enterViewController.delegate = self

        navigationController.pushViewController(enterViewController, animated: true)
    }
    
    func pushToSegmentViewController() {
        delegate?.pushToSegmentViewController()
    }
    
    func popToSettingViewController() {
        delegate?.popToViewController()
    }
}
