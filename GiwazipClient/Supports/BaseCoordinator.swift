//
//  BaseCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class BaseCoordinator: Coordinator {

    // MARK: - Property

    var childCoordinators: [Coordinator] = []

    var rootViewController: UINavigationController!
    var navigationController: UINavigationController!

    // MARK: - init

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Method

    func start() {}
}
