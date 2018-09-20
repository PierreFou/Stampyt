//
//  UIViewControllerExtension.swift
//  Stampyt
//
//  Created by Pierre on 19/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit

extension UIViewController {
        
    /**
     * Display a pop-up with different parameters.
     * Need a title, a message, and a label for the dismiss button
     */
    func displayAlert(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true) {}
    }

}
