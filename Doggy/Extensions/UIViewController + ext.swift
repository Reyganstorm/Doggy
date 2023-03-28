//
//  UIViewController + ext.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, buttonTitle: String, handler: @escaping(UIAlertAction) -> Void ) {
        let alertVC = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .destructive, handler: handler)
        alertVC.addAction(ok)
        present(alertVC, animated: true)
    }
}
