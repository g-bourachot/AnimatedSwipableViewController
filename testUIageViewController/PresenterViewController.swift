//
//  PresenterViewController.swift
//  AnimatedSwipableViewController
//
//  Created by Guillaume Bourachot on 10/07/2017.
//  Copyright © 2017 Guillaume Bourachot. All rights reserved.
//

import Foundation
import UIKit

class PresenterViewController: UIViewController {
    
    @IBAction func presentPressed(_ sender: UIButton) {
        
        let vc = ScrollableViewController()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstViewController = mainStoryboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        let secondViewController = mainStoryboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        let thirdViewController = mainStoryboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        firstViewController.view.backgroundColor = UIColor.green
        firstViewController.countLabel = "0"
        secondViewController.view.backgroundColor = UIColor.red
        secondViewController.countLabel = "1"
        thirdViewController.view.backgroundColor = UIColor.blue
        thirdViewController.countLabel = "2"
        
        vc.contentViewControllers.append(firstViewController)
        vc.contentViewControllers.append(secondViewController)
        vc.contentViewControllers.append(thirdViewController)
        
        vc.startingAnimationDelay = 1.0
        vc.halfwayAnimationDelay = 1
        vc.swippingWidthRatio = 0.5
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.setNavigationBarHidden(true, animated: false)
        self.present(navigationController, animated: true, completion: nil)
    }
}
