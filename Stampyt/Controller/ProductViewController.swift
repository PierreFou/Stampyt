//
//  ProductViewController.swift
//  Stampyt
//
//  Created by Pierre on 19/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit

protocol ProductPageViewControllerDelegate: class {
    func turnPage(to index: Int)
}

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var leftArrowButton: UIButton!
    
    weak var productPageViewControllerDelegate: ProductPageViewControllerDelegate?

    var pageIndex = 0
    var productImage: UIImage?
    var isFirstImage = false
    var isLastImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = productImage {
            productImageView.image = image
        }
        
        if isFirstImage {
            leftArrowButton.isHidden = true
        } else if isLastImage {
            rightArrowButton.isHidden = true
        }
    }
    
    @IBAction func leftArrowClicked() {
        productPageViewControllerDelegate?.turnPage(to: pageIndex - 1)
    }
    
    @IBAction func rightArrowClicked() {
        productPageViewControllerDelegate?.turnPage(to: pageIndex + 1)
    }
    
}
