//
//  SettingCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol SettingCoordinatorDelegate {
    func pushToClientInfoViewController()
    func pushToNoticeViewController()
    func pushToDeveloperViewController()
    func pushToLicenseViewController()
    func showSplashViewController()
    func popToViewController()
}

class SettingCoordinator: BaseCoordinator, SettingViewControllerDelegate {

    // MARK: - Property

    var delegate: SettingCoordinatorDelegate?

    // MARK: - Method

    override func start() {
        let settingViewController = SettingViewController()
        settingViewController.delegate = self

        navigationController.pushViewController(settingViewController, animated: true)
    }
    
    func pushToClientInfoViewController() {
        delegate?.pushToClientInfoViewController()
    }
    
    func pushToNoticeViewController() {
        delegate?.pushToNoticeViewController()
    }
    
    func pushToDeveloperViewController() {
        delegate?.pushToDeveloperViewController()
    }

    func popToSegmentViewController() {
        delegate?.popToViewController()
    }
    
    func pushToLicenseViewController() {
        delegate?.pushToLicenseViewController()
    }
    
    func showSplashViewController() {
        delegate?.showSplashViewController()
    }
}
