//
//  UIAlertController+Present.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/23.
//

import UIKit

extension UIAlertController {
    
    class func present(at viewController: UIViewController, title: String, messsage: String, cancelActionTitle: String, shouldWorkOnMainThead: Bool = false) {
        
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let action = UIAlertAction(title: cancelActionTitle, style: .cancel)
        alert.addAction(action)
        
        if shouldWorkOnMainThead {
            DispatchQueue.main.async {
                viewController.present(alert, animated: true)
            }
            return
        }
        
        viewController.present(alert, animated: true)
    }
}
