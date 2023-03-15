//
//  UIBackBarButton.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

import UIKit

extension UIViewController {
    func backBarButton(_ didTapBackButton: Selector) -> UIBarButtonItem {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                style: .plain,
                                                target: self,
                                                action: didTapBackButton)
        return backBarButtonItem
    }
}
