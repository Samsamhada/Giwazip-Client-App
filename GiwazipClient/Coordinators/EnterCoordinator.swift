//
//  EnterCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol EnterCoordinatorDelegate {
    func presentSegmentView()
    func popToSettingView()
}

class EnterCoordinator: BaseCoordinator, EnterViewControllerDelegate, SettingContentDelegate {
    
    var delegate: EnterCoordinatorDelegate?
    let enterViewController = EnterViewController()
    
    override func start() {
        enterViewController.delegate = self

        navigationController.pushViewController(enterViewController, animated: true)
    }
    
    func presentSegmentView() {
        delegate?.presentSegmentView()
    }
    
    func popToSettingView() {
        delegate?.popToSettingView()
    }
}
