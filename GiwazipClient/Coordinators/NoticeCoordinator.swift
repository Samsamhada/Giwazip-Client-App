//
//  NoticeCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

protocol SettingContentCoordinatorDelegate {
    func popToViewController()
}

class NoticeCoordinator: BaseCoordinator, SettingContentDelegate {
    
    var delegate: SettingContentCoordinatorDelegate?
    
    override func start() {
        let noticeViewController = NoticeViewController()
        noticeViewController.delegate = self

        navigationController.pushViewController(noticeViewController, animated: true)
    }
    
    func popToSettingViewController() {
        delegate?.popToViewController()
    }
}