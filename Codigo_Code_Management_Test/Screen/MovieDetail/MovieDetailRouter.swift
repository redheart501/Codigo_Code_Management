//
//  MovieDetailRouter.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class MovieDetailRouter{
    static func createModule(_ data : resultsMapperResponse) -> UIViewController? {
        guard let view = UIViewController.MovieDetailViewController as? MovieDetailViewController else { return nil }
        view.data = data
        return view
    }
}

