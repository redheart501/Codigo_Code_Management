//
//  TabbarViewController.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class TabbarViewController : UITabBarController{
    
    override func viewDidLoad() {
        if let mainView = MovieListRouter.createModule() {
            viewControllers?[0] = mainView
        }
        let tabBarItems = tabBar.items! as [UITabBarItem]
        tabBar.items![0].image = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
    }
    
}
