//
//  SubCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

protocol SubCoordinatorDelegate {
    func didLoggedOut(_ coordinator: SubCoordinator)
}

//class SubCoordinator: Coordinator, SubViewControllerDelegate {
//
//    // MARK: - Property
//
//    var childCoordinators: [Coordinator] = []
//    var delegate: SubCoordinatorDelegate?
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
//        let viewController = SubViewController()
//        viewController.delegate = self
//
//        self.navigationController.viewControllers = [viewController]
//    }
//
//    func logout() {
//        self.delegate?.didLoggedOut(self)
//    }
//}

class SubCoordinator: BaseCoordinator, SubViewControllerDelegate {

    // MARK: - Property

    var delegate: SubCoordinatorDelegate?

    // MARK: - Method

    override func start() {
        let viewController = SubViewController()
        viewController.delegate = self

        self.navigationController.viewControllers = [viewController]
    }

    func logout() {
        self.delegate?.didLoggedOut(self)
    }
}
