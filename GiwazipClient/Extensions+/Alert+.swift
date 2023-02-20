//
//  Alert+.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/20.
//

import UIKit

extension UIViewController {
    
    func makeAlert(title: String? = "",
                   message: String? = nil,
                   okAction: ((UIAlertAction) -> Void)? = nil,
                   completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: TextLiteral.submitButtonText, style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeAlert(title: String? = "",
                   message: String? = nil,
                   okTitle: String = TextLiteral.submitButtonText,
                   cancelTitle: String = TextLiteral.cancelButtonText,
                   okAction: ((UIAlertAction) -> Void)?,
                   cancelAction: ((UIAlertAction) -> Void)? = nil,
                   completion: (() -> Void)? = nil) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: okTitle, style: .destructive, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeActionSheet(title: String? = nil,
                         message: String? = nil,
                         firstContext: String? = "",
                         secondContext: String? = "",
                         cancelContext: String? = TextLiteral.cancelButtonText,
                         didTapFirst: ((UIAlertAction) -> Void)? = nil,
                         didTapSecond: ((UIAlertAction) -> Void)? = nil,
                         didTapCancel: ((UIAlertAction) -> Void)? = nil) {
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: firstContext, style: .default, handler: didTapFirst)
        let secondAction = UIAlertAction(title: secondContext, style: .destructive, handler: didTapSecond)
        let cancelAction = UIAlertAction(title: cancelContext, style: .cancel, handler: didTapCancel)
        actionSheet.addAction(firstAction)
        actionSheet.addAction(secondAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
}
