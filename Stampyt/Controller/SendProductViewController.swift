//
//  SendProductViewController.swift
//  Stampyt
//
//  Created by Pierre on 19/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit

class SendProductViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendShootingClicked() {
        ShootingService.shared.sendShooting { (success) in
            if !success {
                self.displayAlert(title: Constants.Libelle.Error, message: Constants.Libelle.ErrorSending, button: Constants.Libelle.Okay)
            } else {
                
                self.displayAlert(title: Constants.Libelle.Success, message: Constants.Libelle.PhotoSent, button: Constants.Libelle.Okay)
                
                ShootingService.shared.originalPictures.removeAll()
                ShootingService.shared.stampedPictures.removeAll()
            }
        }
    }
    
    @IBAction func cancelSendingClicked() {
        ShootingService.shared.originalPictures.removeAll()
        ShootingService.shared.stampedPictures.removeAll()
        dismiss(animated: true, completion: nil)
    }

}
