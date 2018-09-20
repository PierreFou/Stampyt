//
//  ShootingService.swift
//  Stampyt
//
//  Created by Pierre on 18/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit
import Alamofire

class ShootingService {
    
    static let shared = ShootingService()
    var originalPictures = [UIImage]()
    var stampedPictures = [UIImage]()
    
    func sendShooting(completion:@escaping (_ success: Bool) -> Void) {
        // On vérifie qu'il y a au moins 2 photos et qu'on a autant d'images orginales que d'images avec filtre
        if originalPictures.count > 1 && stampedPictures.count == originalPictures.count {
            
            let imagesDetails = createImagesDetails(numberOfPhoto: originalPictures.count)
            let body = createBody(withImageDetails: imagesDetails)
            
            Alamofire.request(Constants.Web.UrlSendShooting, method: .post, parameters: body, encoding: URLEncoding.default, headers: Constants.Web.Header).responseString { (response) in
                
                if response.response?.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    // Créer le paramètre body
    func createBody(withImageDetails imagesDetails: String) -> [String: Any] {
        
        var body: [String: Any] = [
            "processes": "{\"cropping\":[\"\"]}",
            "imagesDetails": imagesDetails
        ]
        
        for (index, image) in originalPictures.enumerated() {
            if let dataImage = image.jpegData(compressionQuality: 1) {
                body["imageOriginal_\(index)"] = dataImage
            }
        }
        
        for (index, image) in stampedPictures.enumerated() {
            if let dataImage = image.jpegData(compressionQuality: 1) {
                body["imageStamped_\(index)"] = dataImage
            }
        }
        
        return body
    }
    
    // Créer le paramètres imagesDetails avec les informations des images
    func createImagesDetails(numberOfPhoto: Int) -> String {
        var imagesDetails = "["
        
        for index in 0..<numberOfPhoto {
            imagesDetails += "{\"name\": \"imageStamped_\(index)\", \"maskId\": \"\", \"stampId\": \"\(Constants.Web.StampId)\"},"
            imagesDetails += "{\"name\": \"imageStamped_\(index)\", \"maskId\": \"\", \"stampId\": \"\(Constants.Web.StampId)\"},"
        }
        
        imagesDetails.removeLast()
        imagesDetails += "]"
        
        return imagesDetails
    }
}
