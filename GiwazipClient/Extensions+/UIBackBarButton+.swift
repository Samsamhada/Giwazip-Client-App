//
//  UIBackBarButton+.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/03/14.
//

import UIKit

extension UIViewController {
    func backBarButton(buttonShape: String = "chevron.backward", _ didTapBackButton: Selector) -> UIBarButtonItem {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: buttonShape),
                                                style: .plain,
                                                target: self,
                                                action: didTapBackButton)
        return backBarButtonItem
    }
}
