//
//  SplashCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol SplashCoordinatorDelegate {
    func pushToEnterViewController()
}

class SplashCoordinator: BaseCoordinator, SplashViewControllerDelegate {
    
    var delegate: SplashCoordinatorDelegate?
    
    override func start() {
        let splashViewController = SplashViewController()
        splashViewController.delegate = self

        navigationController.pushViewController(splashViewController, animated: true)
    }
    
    func pushToEnterViewController() {
        delegate?.pushToEnterViewController()
    }
}
