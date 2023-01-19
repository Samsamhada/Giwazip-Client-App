//
//  HideKeyboard+.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/19.
//

import UIKit


extension UIViewController {

    func hidekeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func endEditingView() {
        view.endEditing(true)
    }
}
