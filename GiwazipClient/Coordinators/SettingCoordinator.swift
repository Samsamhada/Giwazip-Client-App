//
//  SettingCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol SettingCoordinatorDelegate {
    func presentClientInfoView()
    func presentNoticeView()
    func presentDeveloperView()
    func presentLicenseView()
    func popToSegmentView()
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
    
    func presentClientInfoView() {
        delegate?.presentClientInfoView()
    }
    
    func presentNoticeView() {
        delegate?.presentNoticeView()
    }
    
    func presentDeveloperView() {
        delegate?.presentDeveloperView()
    }

    func popToSegmentView() {
        delegate?.popToSegmentView()
    }
    
    func presentLicenseView() {
        delegate?.presentLicenseView()
    }
}
