//
//  TabBarViewController.swift
//  Example
//
//  Created by Jose Alcala on 11/11/16.
//  Copyright © 2016 Jose Alcalá Correa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.viewControllers = [GSKAirbnbExampleViewController(),
                                ScalableLabelViewController(),
                                GSKVisibleSectionHeadersViewController()]
    }
    
}
