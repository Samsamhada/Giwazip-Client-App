//
//  Alert+.swift
//  GiwazipClient
//
//  Created by creohwan on 2023/01/20.
//

import UIKit

extension UIViewController {
    
    func makeAlert(title: String? = nil, message: String? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true)
    }
    
    func makeRequestAlert(title: String? = nil,
                          message: String,
                          okTitle: String = "확인",
                          cancelTitle: String = "취소") {

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .destructive)
        alertViewController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true)
    }
}
