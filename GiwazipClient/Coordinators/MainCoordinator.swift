//
//  MainCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

protocol MainCoordinatorDelegate {
    func didLoggedIn(_ coordinator: MainCoordinator)
}

//class MainCoordinator: Coordinator, MainViewControllerDelegate {
//
//    // MARK: - Property
//
//    var childCoordinators: [Coordinator] = []
//    var delegate: MainCoordinatorDelegate?
//
//    private var navigationController: UINavigationController!
//
//    // MARK: - init
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    // MARK: - Method
//
//    func start() {
//        let viewController = MainViewController()
//        viewController.delegate = self
//
//        self.navigationController.viewControllers = [viewController]
//    }
//
//    func login() {
//        self.delegate?.didLoggedIn(self)
//    }
//}

class MainCoordinator: BaseCoordinator, MainViewControllerDelegate {

    // MARK: - Property

    var delegate: MainCoordinatorDelegate?

    // MARK: - Method

    override func start() {
        let viewController = MainViewController()
        viewController.delegate = self

        navigationController.viewControllers = [viewController]
    }

    func login() {
        self.delegate?.didLoggedIn(self)
    }
}
