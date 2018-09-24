//
//  UIImageExtension.swift
//  Stampyt
//
//  Created by Pierre on 24/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit

extension UIImage {
    
    // Applique un filtre particulier sur l'image
    func applyStamp(withSize imageSize: CGSize, andBounds imageBounds: CGRect) -> UIImage? {
        
        if let stamp = UIImage(named: "stamp") {
            
            UIGraphicsBeginImageContext(imageSize)
            
            let areaSize = imageBounds
            self.draw(in: areaSize)
            stamp.draw(in: areaSize, blendMode: .normal, alpha: 0.8)
            
            let stampedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return stampedImage
        }
        
        return nil
    }
}
