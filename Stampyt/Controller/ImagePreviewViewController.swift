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
        applyStamp()
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
    
    // Applique le filtre sur l'image chargée
    func applyStamp() {
        if let image = imageToShow, let stamp = UIImage(named: "stamp") {
            
            UIGraphicsBeginImageContext(previewImageView.frame.size)
            
            let areaSize = previewImageView.bounds
            image.draw(in: areaSize)
            
            stamp.draw(in: areaSize, blendMode: .normal, alpha: 0.8)
            
            let stampedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            previewImageView.image = stampedImage
        } else {
            displayAlert(title: Constants.Libelle.Error, message: Constants.Libelle.NoStamp, button: Constants.Libelle.Okay)
        }
    }
    
}
