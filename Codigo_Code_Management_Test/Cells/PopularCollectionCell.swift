//
//  popularCollectionCell.swift
//  Codigo_Code_Management_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation
import UIKit

class popularCollectionCell : UICollectionViewCell{
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnFav: UIButton!
    var buttonAction: (() -> Void)?

        @IBAction func buttonTapped(_ sender: UIButton) {
            buttonAction?()
        }
}
