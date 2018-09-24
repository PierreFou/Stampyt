//
//  ImagePreviewViewController.swift
//  Stampyt
//
//  Created by Pierre on 18/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    @IBOutlet weak var previewImageView: UIImageView!

    var imageToShow: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ajout du filtre à l'image
        if let image = imageToShow, let stampedImage = image.applyStamp(withSize: previewImageView.frame.size, andBounds: previewImageView.bounds) {
            previewImageView.image = stampedImage
        } else {
            displayAlert(title: Constants.Libelle.Error, message: Constants.Libelle.NoStamp, button: Constants.Libelle.Okay)
        }
    }
    
    @IBAction func validateClicked() {
        if imageToShow != nil && previewImageView.image != nil {
            ShootingService.shared.originalPictures.append(imageToShow!)
            ShootingService.shared.stampedPictures.append(previewImageView.image!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelClicked() {
        dismiss(animated: true, completion: nil)
    }
    
}
