//
//  ProductsPageViewController.swift
//  Stampyt
//
//  Created by Pierre on 19/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit

class ProductsPageViewController: UIPageViewController {

    lazy var controllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: Constants.Identifier.StoryBoardName, bundle: nil)
        var controllers = [UIViewController]()
        
        for (index, image) in ShootingService.shared.stampedPictures.enumerated() {
            if let productVC = storyboard.instantiateViewController(withIdentifier: Constants.Identifier.IdentifierSendProductViewController) as? ProductViewController {
                
                productVC.productImage = ShootingService.shared.stampedPictures[index]
                productVC.productPageViewControllerDelegate = self
                productVC.pageIndex = index
                
                if index == 0 {
                    productVC.isFirstImage = true
                } else if index == ShootingService.shared.stampedPictures.count - 1 {
                    productVC.isLastImage = true
                }
                
                controllers.append(productVC)
            }
        }
        
        return controllers
    }()
    
    override func viewDidLoad() {
        dataSource = self
        
        turn(toPage: 0)
    }
    
    // Permet de changer de page à l'index précisé
    func turn(toPage page: Int) {
        let productVC = controllers[page]
        var direction = UIPageViewController.NavigationDirection.forward
        
        if let currentVC = viewControllers?.first, let index = controllers.index(of: currentVC), index > page {
            direction = .reverse
        }
        
        setViewControllers([productVC], direction: direction, animated: true, completion: nil)
    }
}

extension ProductsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController), index > 0 {
            return controllers[index - 1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController), index < controllers.count - 1 {
            return controllers[index + 1]
        }
        return nil
    }
    
}

extension ProductsPageViewController: ProductPageViewControllerDelegate {
    
    func turnPage(to index: Int) {
        turn(toPage: index)
    }
    
}
