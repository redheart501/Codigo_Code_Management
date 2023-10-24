//
//  UIViewController+Extensions.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import UIKit

extension UIViewController {
    @nonobjc class var tabBarViewController: UIViewController? {
        return UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(withIdentifier: "TabbarViewController")
    }
    @nonobjc class var MovieListViewController: UIViewController? {
        return UIStoryboard(name: "MovieList", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController")
    }
  
    @nonobjc class var MovieDetailViewController: UIViewController? {
        return UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController")
    }

}
