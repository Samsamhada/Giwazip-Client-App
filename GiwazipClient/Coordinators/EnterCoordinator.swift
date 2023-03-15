//
//  EnterCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol EnterCoordinatorDelegate {
    func presentSegmentView()
}

class EnterCoordinator: BaseCoordinator, EnterViewControllerDelegate, SettingContentDelegate {
    
    var delegate: EnterCoordinatorDelegate?
    var settingDelegate: SettingContentCoordinatorDelegate?
    
    override func start() {
        let enterViewController = EnterViewController()
        enterViewController.delegate = self

        navigationController.pushViewController(enterViewController, animated: true)
    }
    
    func presentSegmentView() {
        delegate?.presentSegmentView()
    }
    
    func popToSettingView() {
        settingDelegate?.popToSettingView()
    }
    
}
