//
//  ContentViewController.swift
//  AnimatedSwipableViewController
//
//  Created by Guillaume Bourachot on 10/07/2017.
//  Copyright © 2017 Guillaume Bourachot. All rights reserved.
//

import Foundation
import UIKit

class ContentViewController: UIViewController {
    
    var countLabel : String = "0"
    
    @IBOutlet weak var countUILabel: UILabel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.countUILabel.text = countLabel
    }
    
}
