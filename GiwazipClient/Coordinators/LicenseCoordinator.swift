//
//  LicenseCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

class LicenseCoordinator: BaseCoordinator, SettingContentDelegate {
    
    // MARK: - Property
    
    var delegate: SettingContentCoordinatorDelegate?
    
    // MARK: - Method
    
    override func start() {
        let licenseViewController = LicenseViewController()
        licenseViewController.delegate = self

        navigationController.pushViewController(licenseViewController, animated: true)
    }
    
    func popToSettingViewController() {
        delegate?.popToViewController()
    }
}
