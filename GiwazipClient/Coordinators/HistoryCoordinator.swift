//
//  HistoryCoordinator.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/19.
//

protocol HistoryCoordinatorDelegate {
    func pushToPostViewController()
}

class HistoryCoordinator: BaseCoordinator, HistoryViewControllerDelegate {
    
    // MARK: - Property
    
    var delegate: HistoryCoordinatorDelegate?
    
    // MARK: - Method
    
    override func start() {
        let historyViewController = HistoryViewController()
        historyViewController.delegate = self

        navigationController.viewControllers = [historyViewController]
    }
    
    func pushToPostViewController() {
        delegate?.pushToPostViewController()
    }
}
