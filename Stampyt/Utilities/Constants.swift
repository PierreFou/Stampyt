//
//  Constants.swift
//  Stampyt
//
//  Created by Pierre on 18/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import Foundation

struct Constants {
    struct Web {
        static let UserId = "85"
        
        static let Header = [
            "Content-Type": "multipart/form-data",
            "x-api-key": "xhramLZUnE1Lw5QRAzYG52V2eofQyZQv25O0cnue"
        ]
        static let BaseUrl = "https://api.stampyt.io/rec/"
        static let UrlUser = "\(Constants.Web.BaseUrl)users/"
        static let UrlSendShooting = "\(Constants.Web.UrlUser)\(Constants.Web.UserId)/shootings"
        static let StampId = "bd17a4e5-2688-4db3-93b1-877331a1d7f7"
        
    }
    
    struct Identifier {
        static let StoryBoardName = "Main"
        static let SegueImagePreview = "imagePreview"
        static let SegueSendProduct = "sendProduct"
        static let IdentifierSendProductViewController = "SendProductViewController"
    }
    
    struct Libelle {
        static let Success = "Succès"
        static let PhotoSent = "Vos photos ont bien été envoyées"
        static let Okay = "Ok"
        
        static let Error = "Erreur"
        static let ErrorSending = "Une erreur est survenue durant l'envoie, veuillez réessayer plus tard"
        static let NoStamp = "Impossible de trouver le filtre, veuillez réessayer plus tard"
    }
}
