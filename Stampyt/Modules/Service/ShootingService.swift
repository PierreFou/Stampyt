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
        do {
            // On vérifie qu'il y a au moins 2 photos et qu'on a autant d'images orginales que d'images avec filtre
            if originalPictures.count > 1 && stampedPictures.count == originalPictures.count {
                
                let url = try URLRequest(url: URL(string: Constants.Web.UrlSendShooting)!, method: .post, headers: Constants.Web.Header)
                
                Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        self.addBody(withFormData: multipartFormData)
                },
                    with: url,
                    encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case .success(let upload, _, _):
                            upload.responseString { response in
                                if response.response?.statusCode == 200 {
                                    completion(true)
                                } else {
                                    completion(false)
                                }
                            }
                        case .failure:
                            completion(false)
                        }
                })
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Créer le paramètre body
    private func addBody(withFormData formData: MultipartFormData) {
        addImagesDetails(withFormData: formData)
        
        formData.append(Data(Constants.Web.ParameterProcessesValue.utf8), withName: Constants.Web.ParameterProcesses)
       
        for (index, image) in originalPictures.enumerated() {
            if let dataImage = image.jpegData(compressionQuality: 0.1) {
                formData.append(dataImage, withName: "\(Constants.Web.ParameterOriginal)\(index)", fileName: "\(Constants.Web.ParameterOriginal)\(index).jpeg", mimeType: "image/jpeg")
            }
        }
        
        for (index, image) in stampedPictures.enumerated() {
            if let dataImage = image.jpegData(compressionQuality: 0.1) {
                formData.append(dataImage, withName: "\(Constants.Web.ParameterStamped)\(index)", fileName: "\(Constants.Web.ParameterStamped)\(index).jpeg", mimeType: "image/jpeg")
            }
        }
    }
    
    // Créer le paramètres imagesDetails avec les informations des images
    private func addImagesDetails(withFormData formData: MultipartFormData) {
        var imagesDetails = "["
        
        for index in 0..<originalPictures.count {
            imagesDetails += "{\"name\": \"\(Constants.Web.ParameterOriginal)\(index)\", \"maskId\": \"\", \"stampId\": \"\(Constants.Web.StampId)\"},"
            imagesDetails += "{\"name\": \"\(Constants.Web.ParameterStamped)\(index)\", \"maskId\": \"\", \"stampId\": \"\(Constants.Web.StampId)\"},"
        }
        
        imagesDetails.removeLast()
        imagesDetails += "]"
        
        formData.append(Data(imagesDetails.utf8), withName: Constants.Web.ParameterImagesDetails)
    }
}
