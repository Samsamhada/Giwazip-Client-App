//
//  AppCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

class AppCoordinator: BaseCoordinator, SplashCoordinatorDelegate,
                      EnterCoordinatorDelegate, SegmentCoordinatorDelegate,
                      PostCoordinatorDelegate, PostImageCoordinatorDelegate,
                      SettingCoordinatorDelegate, SettingContentCoordinatorDelegate,
                      PostingCoordinatorDelegate {

    var isLoggedIn = true

    // MARK: - Method

    override func start() {
        if isLoggedIn {
            showSplashViewController()
//            showSegmentViewController()
//            showPostViewController()
        } else {
            showSplashViewController()
        }
    }

    // MARK: - ShowVC Method

    func showSplashViewController() {
        let coordinator = SplashCoordinator(navigationController: navigationController)
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

    // TODO: 뷰 연결 후 삭제
    private func showPostViewController() {
        let coordinator = PostCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    // MARK: - Push

    func pushToEnterViewController() {
        let coordinator = EnterCoordinator(navigationController: navigationController)
        coordinator.enterViewController.isEnterView = true
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func pushToClientInfoViewController() {
        let coordinator = EnterCoordinator(navigationController: navigationController)
        coordinator.enterViewController.isEnterView = false
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func pushToDeveloperViewController() {
        let coordinator = DeveloperCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func pushToLicenseViewController() {
        let coordinator = LicenseCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func pushToNoticeViewController() {
        let coordinator = NoticeCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func pushToPostViewController() {
        let coordinator = PostCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func pushToPostImageViewController() {
        let coordinator = PostImageCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func pushToSegmentViewController() {
        let coordinator = SegmentCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func pushToSettingViewController() {
        let coordinator = SettingCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    // MARK: - Present

    func presentEditingTextView() {
        let coordinator = PostingTextCoordinator(navigationController: navigationController)
        coordinator.isPostTextView = false
        coordinator.start()
    }

    func presentPostingView() {
        let coordinator = PostingCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    // MARK: - Pop
    
    func popToViewController() {
        self.childCoordinators.removeLast()
        navigationController.popViewController(animated: true)
    }

    // MARK: - Dismiss

    func dismissViewController() {
        self.childCoordinators.removeLast()
        navigationController.dismiss(animated: true)
    }
}

