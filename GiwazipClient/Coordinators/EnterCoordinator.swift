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
    
    // MARK: - Property
    
    var delegate: EnterCoordinatorDelegate?
    let enterViewController = EnterViewController()
    
    // MARK: - Method
    
    override func start() {
        enterViewController.delegate = self

        navigationController.pushViewController(enterViewController, animated: true)
    }
    
    func pushToSegmentViewController() {
        navigationController.viewControllers.removeAll()
        delegate?.pushToSegmentViewController()
    }
    
    func popToSettingViewController() {
        delegate?.popToViewController()
    }
}
