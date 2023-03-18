//
//  AppCoordinator.swift
//  GiwazipClient
//
//  Created by 김민택 on 2023/01/13.
//

class AppCoordinator: BaseCoordinator, SplashCoordinatorDelegate,EnterCoordinatorDelegate,
                      SegmentCoordinatorDelegate, PostCoordinatorDelegate,
                      PostImageCoordinatorDelegate,SettingCoordinatorDelegate,
                      SettingContentCoordinatorDelegate, PostingPhotoCoordinatorDelegate,
                      EditingTextCoordinatorDelegate{

    var isLoggedIn = true

    // MARK: - Method

    override func start() {
        if isLoggedIn {
            showSplashViewController()
//            showSegmentViewController()
//            showPostViewController()
        } else {
            showSegmentViewController()
        }
    }

    // MARK: - ShowVC Method

    private func showSplashViewController() {
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

    // MARK: - Present
    
    func presentEnterView() {
        let coordinator = EnterCoordinator(navigationController: navigationController)
        coordinator.enterViewController.isEnterView = true
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func presentSegmentView() {
        let coordinator = SegmentCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentPostingView() {
        let coordinator = PostingCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentPostImageView() {
        let coordinator = PostImageCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func presentPostView() {
        let coordinator = PostCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentEditingView() {
        let coordinator = EditingTextCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }

    func presentSettingView() {
        let coordinator = SettingCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentClientInfoView() {
        let coordinator = EnterCoordinator(navigationController: navigationController)
        coordinator.enterViewController.isEnterView = false
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentNoticeView() {
        let coordinator = NoticeCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentDeveloperView() {
        let coordinator = DeveloperCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func presentLicenseView() {
        let coordinator = LicenseCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    // MARK: - Pop
    
    func popToSegmentView() {
        self.childCoordinators.removeLast()
        navigationController.popViewController(animated: true)
    }
    
    func popToSettingView() {
        self.childCoordinators.removeLast()
        navigationController.popViewController(animated: true)
    }
    
    func popToPostView() {
        self.childCoordinators.removeLast()
        navigationController.popViewController(animated: true)
    }

    // MARK: - Dismiss

    func dismissPostingView() {
        self.childCoordinators.removeLast()
        navigationController.dismiss(animated: true)
    }
    
    func dismissPostingTextView() {
        self.childCoordinators.removeLast()
        navigationController.dismiss(animated: true)
    }
    
    func dismissEditingTextView() {
        self.childCoordinators.removeLast()
        navigationController.dismiss(animated: true)
    }
}

