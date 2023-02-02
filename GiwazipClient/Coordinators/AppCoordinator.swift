//
//  AppCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

class AppCoordinator: BaseCoordinator, MainCoordinatorDelegate, SubCoordinatorDelegate, SegmentCoordinatorDelegate {

    var isLoggedIn = true

    // MARK: - Method

    override func start() {
        if isLoggedIn {
            showSegmentViewController()
        } else {
            showMainViewController()
        }
    }

    // MARK: - ViewController

    private func showSubViewController() {
        let coordinator = SubCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    private func showMainViewController() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    private func showSegmentViewController() {
        let coordinator = SegmentCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    private func showPostingPhotoViewController() {
        let coordinator = PostingPhotoCoordinator(navigationController: navigationController)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    // MARK: - Click Event

    func didLoggedIn(_ coordinator: MainCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showSubViewController()
    }

    func didLoggedOut(_ coordinator: SubCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainViewController()
    }
    
    func presentPostingPhotoView(_ coordinator: SegmentCoordinator) {
        self.childCoordinators = self.childCoordinators.filter{ $0 !== coordinator }
        showPostingPhotoViewController()
    }
}

