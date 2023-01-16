//
//  AppCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

class AppCoordinator: BaseCoordinator, MainCoordinatorDelegate, SubCoordinatorDelegate {

    var isLoggedIn = false

    // MARK: - Method

    override func start() {
        if isLoggedIn {
            showSubViewController()
        } else {
            showMainViewController()
        }
    }

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

    func didLoggedIn(_ coordinator: MainCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showSubViewController()
    }

    func didLoggedOut(_ coordinator: SubCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showMainViewController()
    }
}

