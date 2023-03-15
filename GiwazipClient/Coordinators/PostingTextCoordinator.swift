//
//  PostingTextView.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/16.
//

import Foundation
import UIKit

class PostingTextCoordinator: BaseCoordinator {
    
    override func start() {
        let postingTextViewController = PostingTextViewController()
        
        let navigationController = UINavigationController(rootViewController: postingTextViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.navigationController.present(navigationController, animated: true)
    }
}
