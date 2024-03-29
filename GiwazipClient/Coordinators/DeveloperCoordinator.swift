//
//  DeveloperCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

class DeveloperCoordinator: BaseCoordinator, SettingContentDelegate {

    // MARK: - Property
    
    var delegate: SettingContentCoordinatorDelegate?
    
    // MARK: - Method
    
    override func start() {
        let developerViewController = DeveloperViewController()
        developerViewController.delegate = self

        navigationController.pushViewController(developerViewController, animated: true)
    }
    
    func popToSettingViewController() {
        delegate?.popToViewController()
    }
}
